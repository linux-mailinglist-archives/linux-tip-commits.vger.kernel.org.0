Return-Path: <linux-tip-commits+bounces-7087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BEAC19C4A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02C335645C1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3634DCEE;
	Wed, 29 Oct 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3i9CPLq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKB5dRex"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348934CFB9;
	Wed, 29 Oct 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733453; cv=none; b=ZR2Yh2RDS4UN+POYjGLRMcN/RxUp0QFHOruvl6r9ixxsSMBCvQE0Pi8jI7zKmH1l6zF5/M5hMWSXAt0vSdKBc2pXrLyCdIh+IbzfAXGsUsIxdfvDu4GW3T7/m1O/Is6tCKO02oZPuvIVkvNl5kgnLSO/zjWT4VCosIHHs21Rsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733453; c=relaxed/simple;
	bh=9suxxZgbrIVflxhhV155k4JBn0JRtqVSMRtPFvw3NFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rngSQgyrZEyLOQD++qnBRoAe9cF2B0+WnLYkugV6DXMwA2oHDhqb2sNBai9l2KtUiXcnQdftjEz45lursaZarRhmGKWL3srGdTIOYEosTtj1qLLMmAw4xkYSFqygD6T5g3ANTCzoeDzjQQwhZ5LlevXzmVBroWExbu2KoB8+QYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3i9CPLq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKB5dRex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAD8rzcL8xFWpaIQE2I7NEqI7xEwDNWoKkCUAaoi8yY=;
	b=A3i9CPLqbKtGMX0r51gLW2pVD7UC6H9a+U2bHQFtqIw55KC2IZvnHJrV7wVrC5gZz9KYVx
	bYsumuRiFITypLu6ZZrH2OKL4lGX/VBydPWsngmwDm8f5lkVTG5mrjb8tnWrHt6GZibNem
	713qU/kNy0Y5yWOCFvxXxFjCWlTMmgkEEbLM4MNvqEriabN80pqdkRidZVgimP50lGIkgw
	FS2ez8CAa2YzVJOyREMM4cfN0k0S7yZm6ZrRXJBdH+2spyxlN+us4KunnT60Y6lqjU7oZ+
	rxKsxoKlFmyLJYm6goEZWBRc7EaPdnZsiZSGRJVsFdm6tcFrJnp4p8VoaBvMzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAD8rzcL8xFWpaIQE2I7NEqI7xEwDNWoKkCUAaoi8yY=;
	b=CKB5dRexKPYwVDInw4WJcwBirGFxW4fJJ+Cv0boazBOaTbFWksC3opAjdLSPA854rQ0so3
	dpgZtFmwQTdIvADA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] uaccess: Provide put/get_user_inline()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.609031602@linutronix.de>
References: <20251027083745.609031602@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173344776.2601451.9104112102429510717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     81575ebb64a2aec238d309b1a0f55b792d212e00
Gitweb:        https://git.kernel.org/tip/81575ebb64a2aec238d309b1a0f55b792d2=
12e00
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:09 +01:00

uaccess: Provide put/get_user_inline()

Provide convenience wrappers around scoped user access similar to
put/get_user(), which reduce the usage sites to:

       if (!get_user_inline(val, ptr))
       		return -EFAULT;

Should only be used if there is a demonstrable performance benefit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027083745.609031602@linutronix.de
---
 include/linux/uaccess.h | 50 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 5f142c0..be395f5 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -825,6 +825,56 @@ for (bool done =3D false; !done; done =3D true)						\
 #define scoped_user_rw_access(uptr, elbl)				\
 	scoped_user_rw_access_size(uptr, sizeof(*(uptr)), elbl)
=20
+/**
+ * get_user_inline - Read user data inlined
+ * @val:	The variable to store the value read from user memory
+ * @usrc:	Pointer to the user space memory to read from
+ *
+ * Return: 0 if successful, -EFAULT when faulted
+ *
+ * Inlined variant of get_user(). Only use when there is a demonstrable
+ * performance reason.
+ */
+#define get_user_inline(val, usrc)				\
+({								\
+	__label__ efault;					\
+	typeof(usrc) _tmpsrc =3D usrc;				\
+	int _ret =3D 0;						\
+								\
+	scoped_user_read_access(_tmpsrc, efault)		\
+		unsafe_get_user(val, _tmpsrc, efault);		\
+	if (0) {						\
+	efault:							\
+		_ret =3D -EFAULT;					\
+	}							\
+	_ret;							\
+})
+
+/**
+ * put_user_inline - Write to user memory inlined
+ * @val:	The value to write
+ * @udst:	Pointer to the user space memory to write to
+ *
+ * Return: 0 if successful, -EFAULT when faulted
+ *
+ * Inlined variant of put_user(). Only use when there is a demonstrable
+ * performance reason.
+ */
+#define put_user_inline(val, udst)				\
+({								\
+	__label__ efault;					\
+	typeof(udst) _tmpdst =3D udst;				\
+	int _ret =3D 0;						\
+								\
+	scoped_user_write_access(_tmpdst, efault)		\
+		unsafe_put_user(val, _tmpdst, efault);		\
+	if (0) {						\
+	efault:							\
+		_ret =3D -EFAULT;					\
+	}							\
+	_ret;							\
+})
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,

