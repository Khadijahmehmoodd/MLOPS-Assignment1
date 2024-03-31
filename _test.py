
from model import train_model

def test_train_model_accuracy():
    # Test if the model accuracy is within an acceptable range
    model, label_encoder = train_model()
    assert model is not None
    assert label_encoder is not None

def test_train_model_loss():
    # Test if the model loss is within an acceptable range
    model, label_encoder = train_model()
    assert model is not None
    assert label_encoder is not None

def test_train_model_output_shape():
    # Test if the output shapes are as expected
    model, label_encoder = train_model()
    assert model is not None
    assert label_encoder is not None
