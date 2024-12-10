Return-Path: <linux-tip-commits+bounces-3047-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D89EADF4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 11:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A871888429
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB029199E9D;
	Tue, 10 Dec 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Muime3ua";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJNN0vSs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA878F40;
	Tue, 10 Dec 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826423; cv=none; b=BrXa51U7Y8gNXZzBwc6yT9TQanOmu+reLxrvE2A8PldcAXhnnkrR54sIrJE90PgqUyuRF7PnDsrdiVJSJDTVpyxh76lvfcK6wFWgDaV6Nq/gPmT2k1z8IgsII4BQ5z18BR1dUqeudW4k9ErtsH8+tj5eXgirI8tLSKwVThDeRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826423; c=relaxed/simple;
	bh=4gosl74ULFrnsTEib88w88LiIg7QTsZ9yU2UBqHLx1o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cmctX/9Vt/vQk1Faw17v1MiJITLAWQUYzk/Xzb01mSF27kheXBGmZ2K/XRdDlmyKuHLsfhGc0kdqVI945qoNcE1llGyYXaOf1V/YsyP0XEA0k6mNrmWewl2WyrAhj+vqPhWepfRf/eNANYi0XgjQWW08oJ0fb3YcITSba7MQI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Muime3ua; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJNN0vSs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Dec 2024 10:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4X/LVJKLWfgMgbzVrpQU5XKZr9terWqBA5e+j/+HqxU=;
	b=Muime3uaAM6MXutJdP9/jVk/rmFGVLMHMqNrVl0PXMnhKsdmdAueuxbXbX6itp6uAt4rA8
	bRxcxIOtvMHo8KE0UQ5t5Emq0ZNjd6HO1/mUQLxoYgGO9XU1m06L2tqtIWo/i7oWVFexvn
	MRp/mPI0U6UbQX0ti/8Lh6yrFoWZXApBdzEW3vGGw5Xk7JrzaABC8+4wcx12q+n8F65eTs
	m7+PnlVZTS38xcSaM9mQbsoIyN7VnRWqMpnNcYohMoibM+bD1sJv4iU2reukHMl2MNdCPY
	nTlCd1UjDd8JOBmVXvtEpTvApV5/w/1GafkV7JKL1BB/gR7272Hsi1lKOFsmEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4X/LVJKLWfgMgbzVrpQU5XKZr9terWqBA5e+j/+HqxU=;
	b=JJNN0vSsuHSRPhezyfNhCjkjk5Z0UcY0tGyuCzlnBnGR7u+axZy2osCpsWTg56mb+kJsku
	WyeFx6qI96gpRGAg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/64: Fix spurious undefined reference when
 CONFIG_X86_5LEVEL=n, on GCC-12
Cc: kernel test robot <lkp@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241209094105.762857-2-ardb+git@google.com>
References: <20241209094105.762857-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173382641945.412.11658975177011805962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     35aafa1d41cee0d3d50164561bca34befc1d9ce3
Gitweb:        https://git.kernel.org/tip/35aafa1d41cee0d3d50164561bca34befc1d9ce3
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 09 Dec 2024 10:41:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2024 11:16:32 +01:00

x86/boot/64: Fix spurious undefined reference when CONFIG_X86_5LEVEL=n, on GCC-12

In __startup_64(), the bool 'la57' can only assume the 'true' value if
CONFIG_X86_5LEVEL is enabled in the build, and generally, the compiler
can make this inference at build time, and elide any references to the
symbol 'level4_kernel_pgt', which may be undefined if 'la57' is false.

As it turns out, GCC 12 gets this wrong sometimes, and gives up with a
build error:

   ld: arch/x86/kernel/head64.o: in function `__startup_64':
   head64.c:(.head.text+0xbd): undefined reference to `level4_kernel_pgt'

even though the reference is in unreachable code. Fix this by
duplicating the IS_ENABLED(CONFIG_X86_5LEVEL) in the conditional that
tests the value of 'la57'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241209094105.762857-2-ardb+git@google.com
Closes: https://lore.kernel.org/oe-kbuild-all/202412060403.efD8Kgb7-lkp@intel.com/
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 54f9a8f..22c9ba3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -186,7 +186,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pgd = &RIP_REL_REF(early_top_pgt)->pgd;
 	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
 
-	if (la57) {
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
 		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
 

