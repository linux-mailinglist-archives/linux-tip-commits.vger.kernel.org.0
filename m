Return-Path: <linux-tip-commits+bounces-7208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD76AC2C8EC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCBF3BE8C9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3523233FA;
	Mon,  3 Nov 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cMOrFdZu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cp3tI6CS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3A322A21;
	Mon,  3 Nov 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181287; cv=none; b=uN87ZF0XHJzVKk0xJuXE1jTqnbRUKSBZYSkvFxhp+NaTCtGqNBUfBgeb7tYBlbO9uwW83XKE9CZIcZWGjsb9kf/FVjZzavr/hAP05aIw0yoGdJnzDMOcOFhAahx9ZrJjMe9fB1GM8g91pCJ3nsLzYcJSRu0Cel8XEhfhNG18ddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181287; c=relaxed/simple;
	bh=EbjCITNw9WrxjH151EwQuJc5vwchw+VbA6CRYl0c6CQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iaCszMRQUPeFjt0UQNPTa0G4uthXYwrQyRYikh+AnAjBrFWLO79Qvu9eOdlPP9AzTbEMobL5pXM7B3Z9zXV3pyOgdAMUsSVomto1BxfXbWMN7DhRQIIow9caXc/xUlr8EwYxAe7syHTnu3+5i9eStdxgJ5qqolxUGqEWf4XP6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cMOrFdZu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cp3tI6CS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:48:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sRchOLwMOk8fg+YVXKjRi1K3IbJZDc5VacC2BFwCAM=;
	b=cMOrFdZuHZfk//8xLkl6cKSvqpVKjLm3I3KbqJoSCZvd4u6nVU/uF2ZlEzz70N1To3PLNV
	TiXxJ4Ihb+xp8+dTpXvmJfBGXOgOufAdYEofpitgnWgS6PyIEOTsBb3ays3ZH7ExRJ8Mgp
	1Dk7E6k9zHQHIq6YxmotWAVWx9u6FWonwHI8vgI3yIVhePHEXZT5jiT7YbksVEv69YsWrr
	zPOFdqp4qPg6WcE7dkyWd1SwhXRasHruEywa45hoGefDY39278HZ7hcNT9zrjaUQPC7Bpo
	n7NSoxVlpGUaCAm2V2Z7wGNvtw+RAkLdJG/FBGB8fX5J1Z3eHvlKhBZ89SEdXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sRchOLwMOk8fg+YVXKjRi1K3IbJZDc5VacC2BFwCAM=;
	b=cp3tI6CSdlcsRExQpRXQOoLxyb+y2MdaVhaUKui4HoyfJOxrJffsQc0cYpM5b38dIN+SPc
	AL1uw901Mb0zqmDw==
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
Message-ID: <176218128299.2601451.11164496284331019033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     ffe194fdea838ff55bcf76462c359f4cd733891a
Gitweb:        https://git.kernel.org/tip/ffe194fdea838ff55bcf76462c359f4cd73=
3891a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:11 +01:00

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

