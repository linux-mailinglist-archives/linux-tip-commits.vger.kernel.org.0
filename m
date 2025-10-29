Return-Path: <linux-tip-commits+bounces-7086-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F964C19C53
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B4C1AA7C6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE5934D91E;
	Wed, 29 Oct 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAgDmwLV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x6PwJsI+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6630E0C5;
	Wed, 29 Oct 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733452; cv=none; b=lYMkh0Hechak9jfXRNoPAOO+qhx1JRGAVVTqw69PhwzepLUOX+Y2O0PL/KyGAlj3GjJ2HX+QHxImk1xW8gb8G87zuHlVvunKVTSi2sl9Su5bYfJm4PZ1tcOEcDH3wyB5lMnL+4VRs6bJof1bk688ljAvHiSULUn2wPQxYXhWzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733452; c=relaxed/simple;
	bh=Uoa+15qyiE8H5kydoSyZaOcSQzoD07fxJ7Oq9n2vdHg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NChV47c4/Rdng4f5KS7EwUZOR8Tn1KFb1lvAArLfO7pD1giNENDBbMgPSNuiPX74LunZ5cw6hfbbVi/XT0Extm1jm+P3MW1E7sK4VWY3cAlyuIQl31XWfipQb23ZijFFyQTt62aNsbIqOWRMSd/xjjKIV30dAW+RqMdDYdsl9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAgDmwLV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x6PwJsI+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aIJIjkB1NHxV6IcZYPWjibvihWnNMoSZu9J8moyqm0=;
	b=LAgDmwLVyvvVQXxgFMlh8b2AIrx9Pc8i5nFbIJuj3dC0zVm+ksEcTtl2jpWv5m0viD3fXo
	UiCoIskkVEAC4MTk8Xd8ey4YPGU6Tu7EROZBNij7Q+ahLwG4bb3lF7RbOJGBUqCDo+McPO
	Zzj0Il97FB2ob/1lTU/DkEb6FCCFwl7zgesBOVvjHTFDb9Gw3Ldywtw4Wi/E9AzDYdbNjI
	rxK8yXxHLQ9JOK2i0FUyuLq7POO6oVnXrY3o9dk+tl0VFD8kb8w08TpMDeo7JudGZYKFf/
	LexHlUtBTovqk3CpK7WUun5+rujMZKxJ7852TWUvGAGvEYNHclPG0uIJ0TM1sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aIJIjkB1NHxV6IcZYPWjibvihWnNMoSZu9J8moyqm0=;
	b=x6PwJsI+2bAdPDj3ouGQLCrDWcXjruXOb7EBZBkxaDKx5FGSMrsO5hKYN7mvttWZ9MR9L3
	/LjkUtxnquzWS5Bg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] x86/futex: Convert to scoped user access
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.799714344@linutronix.de>
References: <20251027083745.799714344@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173344538.2601451.6743964082734527611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     72e54de690f970dd3713f874890723b93ab3c80a
Gitweb:        https://git.kernel.org/tip/72e54de690f970dd3713f874890723b93ab=
3c80a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:10 +01:00

x86/futex: Convert to scoped user access

Replace the open coded implementation with the scoped user access
guards

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251027083745.799714344@linutronix.de
---
 arch/x86/include/asm/futex.h | 75 +++++++++++++++--------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 6e24580..fe5d9a1 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -46,38 +46,31 @@ do {								\
 } while(0)
=20
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, in=
t *oval,
-		u32 __user *uaddr)
+						       u32 __user *uaddr)
 {
-	if (can_do_masked_user_access())
-		uaddr =3D masked_user_access_begin(uaddr);
-	else if (!user_access_begin(uaddr, sizeof(u32)))
-		return -EFAULT;
-
-	switch (op) {
-	case FUTEX_OP_SET:
-		unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
-		break;
-	case FUTEX_OP_ADD:
-		unsafe_atomic_op1(LOCK_PREFIX "xaddl %0, %2", oval,
-				   uaddr, oparg, Efault);
-		break;
-	case FUTEX_OP_OR:
-		unsafe_atomic_op2("orl %4, %3", oval, uaddr, oparg, Efault);
-		break;
-	case FUTEX_OP_ANDN:
-		unsafe_atomic_op2("andl %4, %3", oval, uaddr, ~oparg, Efault);
-		break;
-	case FUTEX_OP_XOR:
-		unsafe_atomic_op2("xorl %4, %3", oval, uaddr, oparg, Efault);
-		break;
-	default:
-		user_access_end();
-		return -ENOSYS;
+	scoped_user_rw_access(uaddr, Efault) {
+		switch (op) {
+		case FUTEX_OP_SET:
+			unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
+			break;
+		case FUTEX_OP_ADD:
+			unsafe_atomic_op1(LOCK_PREFIX "xaddl %0, %2", oval, uaddr, oparg, Efault);
+			break;
+		case FUTEX_OP_OR:
+			unsafe_atomic_op2("orl %4, %3", oval, uaddr, oparg, Efault);
+			break;
+		case FUTEX_OP_ANDN:
+			unsafe_atomic_op2("andl %4, %3", oval, uaddr, ~oparg, Efault);
+			break;
+		case FUTEX_OP_XOR:
+			unsafe_atomic_op2("xorl %4, %3", oval, uaddr, oparg, Efault);
+			break;
+		default:
+			return -ENOSYS;
+		}
 	}
-	user_access_end();
 	return 0;
 Efault:
-	user_access_end();
 	return -EFAULT;
 }
=20
@@ -86,21 +79,19 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval=
, u32 __user *uaddr,
 {
 	int ret =3D 0;
=20
-	if (can_do_masked_user_access())
-		uaddr =3D masked_user_access_begin(uaddr);
-	else if (!user_access_begin(uaddr, sizeof(u32)))
-		return -EFAULT;
-	asm volatile("\n"
-		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
-		"2:\n"
-		_ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
-		: "+r" (ret), "=3Da" (oldval), "+m" (*uaddr)
-		: "r" (newval), "1" (oldval)
-		: "memory"
-	);
-	user_access_end();
-	*uval =3D oldval;
+	scoped_user_rw_access(uaddr, Efault) {
+		asm_inline volatile("\n"
+				    "1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
+				    "2:\n"
+				    _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0)
+				    : "+r" (ret), "=3Da" (oldval), "+m" (*uaddr)
+				    : "r" (newval), "1" (oldval)
+				    : "memory");
+		*uval =3D oldval;
+	}
 	return ret;
+Efault:
+	return -EFAULT;
 }
=20
 #endif

