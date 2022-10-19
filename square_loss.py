import torch

def square_loss(predictions, labels, margin=1):
    I_pos = torch.where(labels == 1)[0]
    I_neg = torch.where(labels == 0)[0]
    N = len(I_pos)*len(I_neg)
    z_coeff = margin - predictions[I_pos]
    a_coeff = torch.sum((labels[I_pos])/N)
    b_coeff = torch.sum((2*z_coeff*labels[I_pos])/N, dim = 0)
    c_coeff = torch.sum(((z_coeff**2)*labels[I_pos])/N, dim = 0)
    predicted_value = predictions[I_neg]
    loss_values = a_coeff*(predicted_value**2) + b_coeff*predicted_value + c_coeff
    running_loss = torch.sum(loss_values)
    return running_loss