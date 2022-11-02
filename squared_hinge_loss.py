import torch 

def squared_hinge_loss(predictions, labels, margin=1):
    torch.autograd.set_detect_anomaly(True)
    labels_length = len(labels)
    augmented_predictions = torch.where(labels == 1, predictions,
                                        predictions + margin)
    augmented_indices_sorted = torch.argsort(augmented_predictions)
    predicted_value = predictions[augmented_indices_sorted]
    labels_sorted = labels[augmented_indices_sorted]
    I_pos = torch.where(labels_sorted == 1)[0]
    I_neg = torch.where(labels_sorted == 0)[0]
    N = len(I_pos)*len(I_neg)
    z_coeff = margin - predicted_value
    a_coeff = torch.cumsum((labels_sorted)/N, dim = 0)
    b_coeff = torch.cumsum((2*z_coeff*labels_sorted)/N, dim = 0)
    c_coeff = torch.cumsum(((z_coeff**2)*labels_sorted)/N, dim = 0)
    loss_values = a_coeff*(predicted_value**2) + b_coeff*predicted_value + c_coeff
    return sum(loss_values[I_neg])
