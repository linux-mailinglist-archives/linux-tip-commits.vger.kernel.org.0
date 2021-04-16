Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6826362488
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhDPPyL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhDPPyI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:08 -0400
Date:   Fri, 16 Apr 2021 15:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mW2rOafKba/aTZTT1KWs8ExwjNSRQiS4iSAafebjyMg=;
        b=TNwOPAY5iBfqbA8+ST+gH4zHgGDAg8WYfWbB0IXlUwWBNwuj7HVqknYGh6cB1NsL2fR80C
        6Hwj6C32f3AbFoIl6NAY9HDJV/GZTK4yYBJ1cK1Pz6OihVCiP7jZfaHubfSz+WjRWdH3Fe
        P4R41UJZrgrMMCX1Rf6mJ9zVJIbvi4PA3fgctqjS1APDpIS53eC7E6pPqtBhtm/qnKZUV1
        7lGZYi5JwdWvOlCo8Y+U6YNHWZ821IaZfGYMCeDOY7aAHD5RjrhlPcT04zgGHDAmBmU+in
        hUCBFLbR0VT4u/JABX4hLlH6jzwZvtULwMFjpFvMhHvw0KAy4xCixs8dOaiZ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mW2rOafKba/aTZTT1KWs8ExwjNSRQiS4iSAafebjyMg=;
        b=RMHJQdsiL03A+V+cjO/Y4mP/bflpHwXOAlgzgjeF6fCnxC2gM7ZNAUGu/XBvxi52Qv4sRb
        FKMSdavThIrDvUDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] debugfs: Implement debugfs_create_str()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210412102001.415407080@infradead.org>
References: <20210412102001.415407080@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842202.29796.4622388868015944464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9af0440ec86ebdab075e1b3d231f81fe7decb575
Gitweb:        https://git.kernel.org/tip/9af0440ec86ebdab075e1b3d231f81fe7decb575
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Mar 2021 10:53:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:34 +02:00

debugfs: Implement debugfs_create_str()

Implement debugfs_create_str() to easily display names and such in
debugfs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210412102001.415407080@infradead.org
---
 fs/debugfs/file.c       | 91 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/debugfs.h | 17 +++++++-
 2 files changed, 108 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 686e0ad..9b78e9e 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -865,6 +865,97 @@ struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_bool);
 
+ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct dentry *dentry = F_DENTRY(file);
+	char *str, *copy = NULL;
+	int copy_len, len;
+	ssize_t ret;
+
+	ret = debugfs_file_get(dentry);
+	if (unlikely(ret))
+		return ret;
+
+	str = *(char **)file->private_data;
+	len = strlen(str) + 1;
+	copy = kmalloc(len, GFP_KERNEL);
+	if (!copy) {
+		debugfs_file_put(dentry);
+		return -ENOMEM;
+	}
+
+	copy_len = strscpy(copy, str, len);
+	debugfs_file_put(dentry);
+	if (copy_len < 0) {
+		kfree(copy);
+		return copy_len;
+	}
+
+	copy[copy_len] = '\n';
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, copy, copy_len);
+	kfree(copy);
+
+	return ret;
+}
+
+static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	/* This is really only for read-only strings */
+	return -EINVAL;
+}
+
+static const struct file_operations fops_str = {
+	.read =		debugfs_read_file_str,
+	.write =	debugfs_write_file_str,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+static const struct file_operations fops_str_ro = {
+	.read =		debugfs_read_file_str,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+static const struct file_operations fops_str_wo = {
+	.write =	debugfs_write_file_str,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+/**
+ * debugfs_create_str - create a debugfs file that is used to read and write a string value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
+ * returned.
+ *
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
+ * be returned.
+ */
+void debugfs_create_str(const char *name, umode_t mode,
+			struct dentry *parent, char **value)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
+				   &fops_str_ro, &fops_str_wo);
+}
+
 static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos)
 {
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index d6c4cc9..1fdb434 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -128,6 +128,8 @@ void debugfs_create_atomic_t(const char *name, umode_t mode,
 			     struct dentry *parent, atomic_t *value);
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 				  struct dentry *parent, bool *value);
+void debugfs_create_str(const char *name, umode_t mode,
+			struct dentry *parent, char **value);
 
 struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
@@ -156,6 +158,9 @@ ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos);
 
+ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos);
+
 #else
 
 #include <linux/err.h>
@@ -297,6 +302,11 @@ static inline struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline void debugfs_create_str(const char *name, umode_t mode,
+				      struct dentry *parent,
+				      char **value)
+{ }
+
 static inline struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
 				  struct debugfs_blob_wrapper *blob)
@@ -348,6 +358,13 @@ static inline ssize_t debugfs_write_file_bool(struct file *file,
 	return -ENODEV;
 }
 
+static inline ssize_t debugfs_read_file_str(struct file *file,
+					    char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	return -ENODEV;
+}
+
 #endif
 
 /**
