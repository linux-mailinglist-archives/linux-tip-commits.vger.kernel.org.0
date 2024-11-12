Return-Path: <linux-tip-commits+bounces-2841-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E29C616D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2024 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98EE1F21180
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87A21894F;
	Tue, 12 Nov 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePtVwZ0+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6NzJROR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D81FEFCB;
	Tue, 12 Nov 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439637; cv=none; b=W/tjNFs8kkwzCggq86E+HFmrc+rXlLeJZQMvN8h9jgTbz5+lHldNA7PJaI2osbeqNGYOEXGvf2iBp3T8lFEDG9fF/D8f4aO43VET9mSewXsIXIAdtaBB6fl3DI3LTh02UGRtcroCznmRzXpKqSmZg1ESuo3ZUczfOLXD67rlFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439637; c=relaxed/simple;
	bh=YH2brv/TyQOjMwxIm4UxeA2thGe7AjZYl4hzRDIP7UE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZwFE+l1kLYGNG3Dxkmncn6wuJU/H2fNNNlO6v0UmiTTu/d2JE5qBBDrQi0R7KqXJjdjpk/uIRbm/vuIzqayBc8PxsiqjiatwsON55Nl2uF+ksa5dJvzN4lYC2hSRjGbWkJKnYijeQ4SlT1eO9jL7/S/oerHtixGhImV8yTCqVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ePtVwZ0+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6NzJROR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Nov 2024 19:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731439634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NeVVdBt8XYDcUZLK3uAH/HralHizCbqojlNYwwxGb94=;
	b=ePtVwZ0+d2AxX/YFsXBZ3a7oaIY8CzEgHPCb5CJlb5ZSeUIKQUunspJx6utRiwYVRTJB8U
	A3QwAvAvsXsBpappPTflHcIb+YtQ8wkBCA9H2vBjNKS0BeUnxUgncPvjQZ8IN4lF6zk6wJ
	TtIGGUWWICjWEulyqAytwrTB5Byi4ffqzqEADemgM4NXIbjF+TFQsBr5WTHLNX42blzyVt
	N7bPRaAzWwmwyS/M7TTp/Pjubi2jvFKrQ65y17fAYys6Ig3loZv/utEM8OYOrglYIR++hU
	eNPaENfO1Sn+X332sRs2EnLBuDeyPT0Y5bHHZI5vTrfOJAyvmjaryNMT7ZC1+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731439634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NeVVdBt8XYDcUZLK3uAH/HralHizCbqojlNYwwxGb94=;
	b=F6NzJRORatEXcdEXjfcwJqMm2OW5wdYMcTnsUuuBKGIJFBUhKC5zxxFDvkk7Brw6VjO1Me
	4DCdtA1BDGSLRcAw==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Use vmalloc_array() instead of vmalloc()
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173143963304.32228.265321628400891478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     f060c89dc1a3cfb6db3894e1d96980a568aa355c
Gitweb:        https://git.kernel.org/tip/f060c89dc1a3cfb6db3894e1d96980a568aa355c
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Tue, 12 Nov 2024 19:26:34 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Nov 2024 11:11:42 -08:00

x86/sgx: Use vmalloc_array() instead of vmalloc()

Use vmalloc_array() instead of vmalloc() to calculate the number of
bytes to allocate.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20241112182633.172944-2-thorsten.blum%40linux.dev
---
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 9ace844..1a59e59 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -630,7 +630,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	if (!section->virt_addr)
 		return false;
 
-	section->pages = vmalloc(nr_pages * sizeof(struct sgx_epc_page));
+	section->pages = vmalloc_array(nr_pages, sizeof(struct sgx_epc_page));
 	if (!section->pages) {
 		memunmap(section->virt_addr);
 		return false;

