Return-Path: <linux-tip-commits+bounces-3233-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2D4A11D59
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E263AA25F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572981EEA4D;
	Wed, 15 Jan 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1VKrV7T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRd9tjqr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33ED1FBCBF;
	Wed, 15 Jan 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932674; cv=none; b=XuJr1cKbgazJ6rg1wQm9wDwJ8EORxjA5pBKRYUtmA7MPvaBP4ozPSqaOMR6Rfnw7BLsGndUMAyT/+ZQHYifPXZginyH9oaL8zwBt2aiucW55j854FxCIXH0YL/8QJgpiUM0Wbc2jHSHtmG8sjnq2+pe2XTFNNxp6glViv/7hJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932674; c=relaxed/simple;
	bh=lE6xHbnSFOUxWPQDIZTxRfAhK5NTvqa529IjXEurB3I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rhgSnaoUpPDjERUeT9qDWEK+A2lOKFI3Imy/7Rjkg020pu7BlSol65hWRyD5sjzw9kEBku5TDBWkB1FUaOhgdqz0bCi+vx/IZv73Co7+L0SVfhQngRy5ONJoEELJUb+HN+0Qr6nMKkedBx39pD9KChP7Q18asCqXB5M5khcdYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H1VKrV7T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRd9tjqr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51t21q/xTvYWiosSebc6Y8VcPqQdMb+IxHK+sXz3QPY=;
	b=H1VKrV7TrwC/qy8S+E2gFI0qgfvNB4gbXENGrodwCKQoGmg9C3Nv1qwu36ku9Fw8LuCUGE
	rBIM1daTN7pZdH8K3jyDTiY4wtv5tjyPfMMqqI2uzbOVtCb4FROy906ysLps15bfBlImDJ
	dcHmnEf/8/YB6iTOGDxdaF3vjURvI/WzjvjpNJNIPeAUGwoiKyvKhh9nqjqvK4Ke9ljocf
	sTTmRS9w8+K5CLU0qz5ZeDtx9JBe5z1kutf0Wbw5o7xRadhE3Zq2F4H/8eF3gnVOoU9SPq
	SyYe0Tc1XHR/V8xdR9+/enSG3yVYbSNiCioFVXMbY8yJSoRm5ssMac9HwJExXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51t21q/xTvYWiosSebc6Y8VcPqQdMb+IxHK+sXz3QPY=;
	b=jRd9tjqrs5w173059OWkita/J8LFRsBJ4Jg/i16sAm2J6GPS6yT9g6kBbJufQuXfBBi4P8
	z5nqdA4X1V62z/CQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/sev: Disable ftrace branch profiling in SEV startup code
Cc: kernel test robot <lkp@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250107151826.820147-2-ardb+git@google.com>
References: <20250107151826.820147-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267039.31546.249038702954750742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     cf4ca80650908628bf1c0c29e3fd236b1915d789
Gitweb:        https://git.kernel.org/tip/cf4ca80650908628bf1c0c29e3fd236b1915d789
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 07 Jan 2025 16:18:27 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 19:10:32 +01:00

x86/sev: Disable ftrace branch profiling in SEV startup code

Ftrace branch profiling inserts absolute references to its metadata at
call sites, and this implies that this kind of instrumentation cannot be
used while executing from the 1:1 mapping of memory.

Therefore, disable ftrace branch profiling in the SEV startup routines,
by disabling it for the entire SEV core source file.

Closes: https://lore.kernel.org/oe-kbuild-all/202501072244.zZrx9864-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250107151826.820147-2-ardb+git@google.com
---
 arch/x86/coco/sev/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 8689854..b5c6c4a 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -9,6 +9,8 @@
 
 #define pr_fmt(fmt)	"SEV: " fmt
 
+#define DISABLE_BRANCH_PROFILING
+
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
 #include <linux/cc_platform.h>

