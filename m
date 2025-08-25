Return-Path: <linux-tip-commits+bounces-6347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBDB33C94
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A71D17BA1A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F542E1EE9;
	Mon, 25 Aug 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MfzIbMbP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RxlEeNVo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531472D5C73;
	Mon, 25 Aug 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117478; cv=none; b=f68z6vgYJp4WIL7lC0CxQIeZU86LAHybmQyJHPuvddc8nQOHbblSG33jPyjtgUW9f+FYlRn5bLUo+5HDlIWz9PVYUbu5+9Yu/tXi1rEd1UOAU5E/9ualykUpRnvvsmDQ0TgViQfn5JQtiQ9cU2sli1GdHl37sFnLM1D3acGrJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117478; c=relaxed/simple;
	bh=uLXMCRM2zmhizsACTxurPlV9qPk7qeIQkPF3CD0tPnM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ck9bkxB5p3gUw3XC5U3qZqs777O2pYgRnXOhSFcriyHm+gowoeFdjjfQCD55mKi0Xxq6k9y9jHjz+KMvW5l9drgNdYelvOTcxOsMCw+1VapwNAus/HZ1oNIOg6uJ1L/O4u1skLkUiJimC/UxqDUwNT7y/wrTQDnP4nBitHl70Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MfzIbMbP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RxlEeNVo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGoAjRGANZMBc6BPGwnXZxgjLdBvyn9NY1YQaeVNfRk=;
	b=MfzIbMbPssLuq2KeNxLKRKwy973ZquYWiYTtnGZdyuEJwXdpzecjnOOlxXQD5EM9KP53Vl
	pFerPG8MlCZbogdoE7fKlM8HVnelq+KDRjbPJhheMFvfFnrvv2SepGwcZpA28j2gU7ljF/
	K4hnRbcFz1IcdLtM+YIvY9q8ynfqTNIZr/lFKAPk4NNXeYfnPqICFKYHrsWUMlULunLnh2
	BG2qjwir+JByYWMvk979cLT3TjMyzmQwA4o2nU86+oS8OeUY0X8ui2BMSf8i4C7aUfLxs8
	467XDJGD5LTzfxQ5eC2sZw/9Ir2lA14TIjtlVC2KkJx6axis/zIp3mFZ6wS0Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGoAjRGANZMBc6BPGwnXZxgjLdBvyn9NY1YQaeVNfRk=;
	b=RxlEeNVoW8qdO1aZSKa7Mrh3uKb7c16tUN2HtUrLi6gZ3AtSxh55ZpYtKWX2HBL4J/nfhg
	wpf8MLatXBE4kGCw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: Fix uprobe syscall shadow stack test
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821141557.13233-1-jolsa@kernel.org>
References: <20250821141557.13233-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611747450.1420.4302564633052286661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     52718438af2ac8323aeea41b6f59da0962cb73b6
Gitweb:        https://git.kernel.org/tip/52718438af2ac8323aeea41b6f59da0962c=
b73b6
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 21 Aug 2025 16:15:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:25 +02:00

selftests/bpf: Fix uprobe syscall shadow stack test

Now that we have uprobe syscall working properly with shadow stack,
we can remove testing limitations for shadow stack tests and make
sure uprobe gets properly optimized.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250821141557.13233-1-jolsa@kernel.org
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 24 ++------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/=
testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c1f945c..5da0b49 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -403,8 +403,6 @@ static void *find_nop5(void *fn)
=20
 typedef void (__attribute__((nocf_check)) *trigger_t)(void);
=20
-static bool shstk_is_enabled;
-
 static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t tr=
igger,
 			  void *addr, int executed)
 {
@@ -413,7 +411,6 @@ static void *check_attach(struct uprobe_syscall_executed =
*skel, trigger_t trigge
 		__s32 raddr;
 	} __packed *call;
 	void *tramp =3D NULL;
-	__u8 *bp;
=20
 	/* Uprobe gets optimized after first trigger, so let's press twice. */
 	trigger();
@@ -422,17 +419,11 @@ static void *check_attach(struct uprobe_syscall_execute=
d *skel, trigger_t trigge
 	/* Make sure bpf program got executed.. */
 	ASSERT_EQ(skel->bss->executed, executed, "executed");
=20
-	if (shstk_is_enabled) {
-		/* .. and check optimization is disabled under shadow stack. */
-		bp =3D (__u8 *) addr;
-		ASSERT_EQ(*bp, 0xcc, "int3");
-	} else {
-		/* .. and check the trampoline is as expected. */
-		call =3D (struct __arch_relative_insn *) addr;
-		tramp =3D (void *) (call + 1) + call->raddr;
-		ASSERT_EQ(call->op, 0xe8, "call");
-		ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	}
+	/* .. and check the trampoline is as expected. */
+	call =3D (struct __arch_relative_insn *) addr;
+	tramp =3D (void *) (call + 1) + call->raddr;
+	ASSERT_EQ(call->op, 0xe8, "call");
+	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
=20
 	return tramp;
 }
@@ -440,7 +431,7 @@ static void *check_attach(struct uprobe_syscall_executed =
*skel, trigger_t trigge
 static void check_detach(void *addr, void *tramp)
 {
 	/* [uprobes_trampoline] stays after detach */
-	ASSERT_OK(!shstk_is_enabled && find_uprobes_trampoline(tramp), "uprobes_tra=
mpoline");
+	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
 	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
 }
=20
@@ -642,7 +633,6 @@ static void test_uretprobe_shadow_stack(void)
 	}
=20
 	/* Run all the tests with shadow stack in place. */
-	shstk_is_enabled =3D true;
=20
 	test_uprobe_regs_equal(false);
 	test_uprobe_regs_equal(true);
@@ -655,8 +645,6 @@ static void test_uretprobe_shadow_stack(void)
=20
 	test_regs_change();
=20
-	shstk_is_enabled =3D false;
-
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
=20

