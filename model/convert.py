import tensorflow as tf

saved_model_path = 'my_model'
model = tf.saved_model.load(saved_model_path)

converter = tf.lite.TFLiteConverter.from_saved_model(saved_model_path)
tflite_model = converter.convert()

tflite_model_path = 'litemodel'
tf.io.write_file(tflite_model_path, tflite_model)