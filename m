Return-Path: <linux-tip-commits+bounces-6867-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F5BE287F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DB10350F7C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB45323414;
	Thu, 16 Oct 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="33/poPM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UTT94uZu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3C31D73E;
	Thu, 16 Oct 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608349; cv=none; b=eY/1jO5owlhx+C/bAloIqJST2LgxRHIi/aFlLcoubAToVJ95XAyKgPpNW8EZ4/HBo28flymBDdRXRT/CBvGC6c4yOgaOGoZTX0/0R+RcmEEpaoyyjg4gRVvUifRsXLukHHBefYPrxPWTtVLz/7I83uR5tYvBUdDkbCnESfgw8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608349; c=relaxed/simple;
	bh=qtdh9dykUTJuqjls5sBmI8gp+n5xf3n4lmj6Lg5oLE0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SLfKwXPsXCzw3Vl3z88WD713mmX/cBmWXSyV4ptfXzS6oBODhflkS3TTCtgKW7IcyUAQyVYvXZ7CdjzbMa0esGAqU76yy7sGKSlwIvh0qfhDT+iJWz+y198YuhXL2qLR01C2nWQzOlMRQrKIHd+bPVxjt6V0cdjMeWfdfeW4GSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=33/poPM/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UTT94uZu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+e4HXCMC+CcPLFhXmeJ3+d00dODvtpGM1Y8wM8vV8Js=;
	b=33/poPM/G2TU/UzrtQdMxrFxjtl2kI/P39FD2IkJOFK22TeTPEocvC5DK7QG7Se9QpEStZ
	MwMloqSKZ0KZRsnVvozUtWQTRDgHEbKIjjP8c/olUshQNJ4AF45iwJ59A1tmrKZgEdzqro
	c6kVteNqsx4SnPVkLda9THgYNyhYxrpJOosXRCKrT7aoCj+RirnjfNAaJAu4AZmRW69sdi
	hRbbVaS/L2SUSNuec87y2lpyetDJUsFa4AF3jNNnWytixCixYFqQ37dmK0Bhz+SFd62Ffe
	vq++P6aU0k4gGszisrjN/uWiFyNSUkOZPUJfCFGRfAsJmmqZAYR0cOC8n10IAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+e4HXCMC+CcPLFhXmeJ3+d00dODvtpGM1Y8wM8vV8Js=;
	b=UTT94uZuHXQl2ipkc56gqJhQrw4Fm2P0CXS/nmhpai86OZNC5opl5DdTRMnz4DbkfO6ktR
	MeAWMKDKCCeVEoDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] livepatch: Introduce source code helpers for
 livepatch modules
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060832056.709179.4024440136652741697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b9976fa4649627c04dde26183333c3dcc90a0b76
Gitweb:        https://git.kernel.org/tip/b9976fa4649627c04dde26183333c3dcc90=
a0b76
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:11 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:19 -07:00

livepatch: Introduce source code helpers for livepatch modules

Add some helper macros which can be used by livepatch source .patch
files to register callbacks, convert static calls to regular calls where
needed, and patch syscalls.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/livepatch_helpers.h | 77 ++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+)
 create mode 100644 include/linux/livepatch_helpers.h

diff --git a/include/linux/livepatch_helpers.h b/include/linux/livepatch_help=
ers.h
new file mode 100644
index 0000000..99d68d0
--- /dev/null
+++ b/include/linux/livepatch_helpers.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LIVEPATCH_HELPERS_H
+#define _LINUX_LIVEPATCH_HELPERS_H
+
+/*
+ * Interfaces for use by livepatch patches
+ */
+
+#include <linux/syscalls.h>
+#include <linux/livepatch.h>
+
+#ifdef MODULE
+#define KLP_OBJNAME __KBUILD_MODNAME
+#else
+#define KLP_OBJNAME vmlinux
+#endif
+
+/* Livepatch callback registration */
+
+#define KLP_CALLBACK_PTRS ".discard.klp_callback_ptrs"
+
+#define KLP_PRE_PATCH_CALLBACK(func)						\
+	klp_pre_patch_t __used __section(KLP_CALLBACK_PTRS)			\
+		__PASTE(__KLP_PRE_PATCH_PREFIX, KLP_OBJNAME) =3D func
+
+#define KLP_POST_PATCH_CALLBACK(func)						\
+	klp_post_patch_t __used __section(KLP_CALLBACK_PTRS)			\
+		__PASTE(__KLP_POST_PATCH_PREFIX, KLP_OBJNAME) =3D func
+
+#define KLP_PRE_UNPATCH_CALLBACK(func)						\
+	klp_pre_unpatch_t __used __section(KLP_CALLBACK_PTRS)			\
+		__PASTE(__KLP_PRE_UNPATCH_PREFIX, KLP_OBJNAME) =3D func
+
+#define KLP_POST_UNPATCH_CALLBACK(func)						\
+	klp_post_unpatch_t __used __section(KLP_CALLBACK_PTRS)			\
+		__PASTE(__KLP_POST_UNPATCH_PREFIX, KLP_OBJNAME) =3D func
+
+/*
+ * Replace static_call() usage with this macro when create-diff-object
+ * recommends it due to the original static call key living in a module.
+ *
+ * This converts the static call to a regular indirect call.
+ */
+#define KLP_STATIC_CALL(name) \
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+
+/* Syscall patching */
+
+#define KLP_SYSCALL_DEFINE1(name, ...) KLP_SYSCALL_DEFINEx(1, _##name, __VA_=
ARGS__)
+#define KLP_SYSCALL_DEFINE2(name, ...) KLP_SYSCALL_DEFINEx(2, _##name, __VA_=
ARGS__)
+#define KLP_SYSCALL_DEFINE3(name, ...) KLP_SYSCALL_DEFINEx(3, _##name, __VA_=
ARGS__)
+#define KLP_SYSCALL_DEFINE4(name, ...) KLP_SYSCALL_DEFINEx(4, _##name, __VA_=
ARGS__)
+#define KLP_SYSCALL_DEFINE5(name, ...) KLP_SYSCALL_DEFINEx(5, _##name, __VA_=
ARGS__)
+#define KLP_SYSCALL_DEFINE6(name, ...) KLP_SYSCALL_DEFINEx(6, _##name, __VA_=
ARGS__)
+
+#define KLP_SYSCALL_DEFINEx(x, sname, ...)				\
+	__KLP_SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
+
+#ifdef CONFIG_X86_64
+// TODO move this to arch/x86/include/asm/syscall_wrapper.h and share code
+#define __KLP_SYSCALL_DEFINEx(x, name, ...)			\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	__X64_SYS_STUBx(x, name, __VA_ARGS__)				\
+	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{								\
+		long ret =3D __klp_do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#endif
+
+#endif /* _LINUX_LIVEPATCH_HELPERS_H */

