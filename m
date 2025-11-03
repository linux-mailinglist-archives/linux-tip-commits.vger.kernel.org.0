Return-Path: <linux-tip-commits+bounces-7207-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DDC2C8D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610D94F742D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6B321F3E;
	Mon,  3 Nov 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgRscJG1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3jR1sUk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F573203AA;
	Mon,  3 Nov 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181284; cv=none; b=dmZOcMIwhRrJLyuhJVv6OOxl+0C0cjWX/D3tmPekrjZUvjZBDvm78DhA4kP973vg22AyxYBARjaTUDe5pdEFxZKYx0ZT+i9ZGkrTQXqAhJb2AXLvtzA7zs2vVg0QPJTgPVbMN99NV1tR5B3DdhIRdkMoQaiSN9zPsiqyreGl1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181284; c=relaxed/simple;
	bh=YgQDKLPlzUz5kAUUXEnO+Bcql1PN3qdaYF0NTIsiMQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u7KDgdtARSCoYC28QBrkl/NmABC0OMsXi20TPiQv5/VHBA6dncK0WvkLT0zPlJBpYfISzxsN9hXVK2Icj8MRKUZwRcsmoACG92+WSoO6xH3KyIuSaeiFMWZbe2z5FpE2duET9wX+Gct5Fb6yrapk4G9XyyaFvUoLaXU8yF9T+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgRscJG1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3jR1sUk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:48:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGIks0Z07vhYsS+IwjO3fVuj0LubazUI1CHzj9JNbho=;
	b=sgRscJG1pkeVzfk9H27rIfQxm/+LLu/WihgBhwE/8HLYEyFSLEmbRD3kBE6HT1jSS03/AW
	+hwChVixoq1kZmUR194gvSkHLBxyaEnc1YuB9+Mw/ibIghaJjmfrRFxjv5A+bhTPIUo4g3
	59Ew2hcT8hHeXEdD3BHtTjoJTQKk5v1vLasRMLHaLOcE2f7d2SCuUGQ12WJv6Shi6RrSIP
	HPUiFvPO3dwtiRap1tJa426cl0iiBnwb8nSvPdvll/IUSapoYW84UzKY1lzp+DXlNUyeTv
	1WlCTRrw6BU5yWHl5DrSMm6ApCW9+XKKOwMqv4fAUiNFQA5WBH9dxHpiiwZVhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGIks0Z07vhYsS+IwjO3fVuj0LubazUI1CHzj9JNbho=;
	b=H3jR1sUkoRJ5kMRJ2MmlgW5qd8Sb8yRGKhTFXDA8YrO7pfdA0QmuHmVJXDcf3nPQgchro1
	sSBPu7+dBeXx/jDQ==
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
Message-ID: <176218128042.2601451.14577918366554931288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     3f126054fc5d299606857851c7e678c6664c14cc
Gitweb:        https://git.kernel.org/tip/3f126054fc5d299606857851c7e678c6664=
c14cc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:12 +01:00

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

