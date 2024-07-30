Return-Path: <linux-tip-commits+bounces-1863-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4794146C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA861C23050
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A31B19F497;
	Tue, 30 Jul 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZlWpwq9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GoJ3JWd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D118FC75;
	Tue, 30 Jul 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349993; cv=none; b=DxeCk6JkUtbNg/YZvmKEk6rj+/QuBRL9yDiJ6sAtHEuNn2+LKfruUbIZe+68t4TZcqFFc1FbbFM0Pt9aR5WHfs6oJxen65WoNLid7SO+zCyxdcv2nh49+TpbVfbNqJgoP9zehpQDBVyla5hrfKvZprN3iDQn+Y/Dmsanf//TXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349993; c=relaxed/simple;
	bh=jeTAxqsiyX+6umWFKJH7PWmwa+Sri6G1UKu82rEKVYw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ehT3EMFpLc8C6rh7GIJfXMrYdSdVF9WnJYPWUV7kOE/nTvjvQeqwTBj0TF6x8GGRda5lbQcKCTIkJqCD09Xbe1LnJ42Dd4AO7RBsq/N/wyQdk+l0sn88uRIv9WMy0xfUP9+KxI6PvVXJXHio0M1tpRCcQWtqTe1Zqg4HqXU/xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZlWpwq9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GoJ3JWd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:33:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722349990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XnrtaEOd+Ljz/9tcrdu6izQHx9yvgBNN7qWPVfcs4uk=;
	b=rZlWpwq9jp559olkII7zOBLRbbexLkn0o8nbAPvdmdOTwG9T8WHbeKpdO4mepHjEf/1FSm
	8q0Mcl1H1h1dJkYZLlGH7to/PWcVJFZ3hmwgXunVVyfMKRlB3+MGXZz6wA1510VFXz6sza
	wlDHVPPzVAf2ZNXL8zrOp5NH4PYPphRcySEn4EXnEWZ8F950eyH/SHkOcD+rwRPWn8AZaG
	CtVe2l+lmm2EM40xmnV5qYgHXHzYJ+knkTLeqId5WnyhtHvICHZZS9D3gu9aOyIwYtDgRe
	51WcwHaMhDoz7tD1B/6lyqRdGNRYa083Ebxiubjw0Z/FSJB+xMzIOBz1xNWUWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722349990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XnrtaEOd+Ljz/9tcrdu6izQHx9yvgBNN7qWPVfcs4uk=;
	b=8GoJ3JWd3ElW0nwudDGui6Hn+sXqjSUYNNqohgtJJpx6AhFwA0A3OQwQVhdkihGp7m8Pln
	2+kUYcy2JDVnRoBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Fix a
 -Wsometimes-uninitialized clang false positive
Cc: kernel test robot <lkp@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234998969.2215.14054341190096493979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     5343558a868e7e635b40baa2e46bf53df1a2d131
Gitweb:        https://git.kernel.org/tip/5343558a868e7e635b40baa2e46bf53df1a2d131
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jul 2024 09:52:43 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 09:52:43 +02:00

x86/microcode/AMD: Fix a -Wsometimes-uninitialized clang false positive

Initialize equiv_id in order to shut up:

  arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is \
  used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (x86_family(bsp_cpuid_1_eax) < 0x17) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

because clang doesn't do interprocedural analysis for warnings to see
that this variable won't be used uninitialized.

Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407291815.gJBST0P3-lkp@intel.com/
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 1f5d36f..f63b051 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -703,7 +703,7 @@ static struct ucode_patch *find_patch(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	u32 rev, dummy __always_unused;
-	u16 equiv_id;
+	u16 equiv_id = 0;
 
 	/* fetch rev if not populated yet: */
 	if (!uci->cpu_sig.rev) {

