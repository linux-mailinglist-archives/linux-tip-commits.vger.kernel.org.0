Return-Path: <linux-tip-commits+bounces-7256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD588C2FD58
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88FAF34D50A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F03271F2;
	Tue,  4 Nov 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gn78VzW6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBOjmf6a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A232572B;
	Tue,  4 Nov 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244273; cv=none; b=L5A08OW5oBER6gm0xM1oLB2rB+yx941sIsvitXKwnO6TCjHqse/Dl+AQBOFMTZEI5F9VUnotIHq4ZVgttSNb9m8XggiCVV9TX7a82pSYSSPzvlysFp9bWVh2I9JXo65dZd8Y3W7cpgFsebdrfQXH3Dc8ZC0wOgss9io8F/50SEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244273; c=relaxed/simple;
	bh=GF5d98CcYFGHO0rk1eJeBxX5/aUM9Rmesl4VmWGw9CI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Py0T8q2ou1Yoz6CriNFxKbjGk7TyvYXW1Fb9tExDaT+eGJgapks0RhjoknuGWYKAyY8dnEKns217Dkmkuz2cbbj6IbqXxF+wlxRs8IDmaHU1ing6S95kYOrAK3JP2uYHOvxrbSed9WNl8lBpFt9+tXYwTQqI5DlUW5R7aHKU1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gn78VzW6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBOjmf6a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oyk6OHYw0px0giJ0sq3xyS6OCRelOTFS5N9VWtAz0e8=;
	b=gn78VzW6Oy+cMhBPm24eA1IBx9coyYQ080BbxjARtHZkIVX7AiFF0iW7ZXuaUizAGICwnR
	jprtujnsbdjBBSKf4JTfdqaz9jrE0XqN0fj6hbdnz1shVFSD8OYknqyQf6X5/Y+7DoGGXD
	oQmpLDjz77vUzr8mRjuPDscVvqATfj+lYXmk0XQPyNrXAPX+k7mSa88lhVm6dBtpMZY9y1
	62PkQDxeVvsnTlp/BtbqbmVSriHqPZkHjLwqKrH4aHKh69yTHpzmUu4v4dMdPCmmSIgyO1
	aXL9akwxmJbQUJMUH36eKpKF0QSfzk7A9P6qIT3J27KS6mj/2ikSKpdUDS15Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oyk6OHYw0px0giJ0sq3xyS6OCRelOTFS5N9VWtAz0e8=;
	b=BBOjmf6a+AdRj/jOUJ/ObUIHUFg8sVRbLkW4WWSz8wTuOmUQ+5zemFqo0PU1l2HTx9KP0+
	9uXafjC+MMM0euBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] uaccess: Provide put/get_user_inline()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <176224426874.2601451.3188194845887152827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     b2cfc0cd68b830dde80fce2406580e258a1e976d
Gitweb:        https://git.kernel.org/tip/b2cfc0cd68b830dde80fce2406580e258a1=
e976d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:28:15 +01:00

uaccess: Provide put/get_user_inline()

Provide convenience wrappers around scoped user access similar to
put/get_user(), which reduce the usage sites to:

       if (!get_user_inline(val, ptr))
       		return -EFAULT;

Should only be used if there is a demonstrable performance benefit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

