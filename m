Return-Path: <linux-tip-commits+bounces-3349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E11A2FDF5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Feb 2025 23:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D27616085F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Feb 2025 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37725A327;
	Mon, 10 Feb 2025 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17+NwEOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iWp8JE66"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871F259498;
	Mon, 10 Feb 2025 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228345; cv=none; b=i9ZyrBx0zLRLfOkDImwyZEsKQGDosS8kfmf/mGM6EzbQz8WNUWYDK58R7J6nFFAseaxHGd+g3F6nQBgtzD6P0e3zM15CRYeMiA5vwfqUU2zQP5yRlgkqaLMNao56Lp6BJCByZMOPevGAQ+RDfNioTcnKHwGwpzcPSLQYOEkKruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228345; c=relaxed/simple;
	bh=Fk1azYuFQHAswP5Ho7T+xUf6Gp56bO005ZzH+4Da4QM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ehdtrUbpdupEhIBFOWIi8LejDgq7S2Ei4ctpLmPUw2bPOBJZjHLwoKLnDr7yLSwsMZjEY+QR7E+C0r67r44l3HTc11KXQ82odc68hIODHMusUEc2cO2o03Enyr5wkpElR4vI6BxOtsE1NwMZJ9SeV0grXaAwEAaXOO9S8bvizc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17+NwEOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iWp8JE66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Feb 2025 22:58:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739228341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9vFG05ZBCSIl92GevUiwsuMRZtjcIfxZJzJtSVWIBGw=;
	b=17+NwEOm9Wub+LpA15oz8nnHaadZnORqW+C3yv3bsCdpHVCjiCnlsB8s8RLnV+ljn7ybN5
	elsEmK8+hsceYcDtqrS4Yr0CjSKgpK/g545ryQW62YXl615t39gqWH3q1/FJOF9YTeGN/Y
	zmVIzYWPJNycSmxQ/iU3PFH2cMEdDgvyj7Ca331QiPI7Y6k4yZCfSrRg+8FYSK/SVLg8Bc
	ZhxnC4dGkg5KgyWFR53BSE/wG4h//o5Tnt13rvKQWuJ5W/fBuge1EEM4LbT0OFimreKrXX
	UVvFlxihaLXzQZiUUQHpxNZC7oX/LNiCjlo8tCbU98Uh/Y+72Abs7PVFF39O+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739228341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9vFG05ZBCSIl92GevUiwsuMRZtjcIfxZJzJtSVWIBGw=;
	b=iWp8JE66kAaqE0gwEua0081BogyTDOUK0XqeYLXXkQTQLFmIwpvsKSSocrXsVa+rIdwiLl
	2OvI4iHCSgppCrDg==
From: "tip-bot2 for Eric Biggers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Fully optimize out WARN_ON_FPU()
Cc: Sean Christopherson <seanjc@google.com>,
 Eric Biggers <ebiggers@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173922833909.10177.3477028255611601484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ccb7735a1ea22621f21c3133e4f5f3da5fe5f5b7
Gitweb:        https://git.kernel.org/tip/ccb7735a1ea22621f21c3133e4f5f3da5fe5f5b7
Author:        Eric Biggers <ebiggers@google.com>
AuthorDate:    Mon, 27 Jan 2025 14:45:23 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 10 Feb 2025 14:45:59 -08:00

x86/fpu: Fully optimize out WARN_ON_FPU()

Currently WARN_ON_FPU evaluates its argument even if
CONFIG_X86_DEBUG_FPU is disabled, which adds unnecessary instructions to
several functions, for example kernel_fpu_begin().  Fix this by using
BUILD_BUG_ON_INVALID(x) in the no-debug case rather than (void)(x).

Fixes: 83242c515881 ("x86/fpu: Make WARN_ON_FPU() more robust in the !CONFIG_X86_DEBUG_FPU case")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250127224523.94300-1-ebiggers%40kernel.org
---
 arch/x86/kernel/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index dbdb31f..975de07 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -18,7 +18,7 @@ static __always_inline __pure bool use_fxsr(void)
 #ifdef CONFIG_X86_DEBUG_FPU
 # define WARN_ON_FPU(x) WARN_ON_ONCE(x)
 #else
-# define WARN_ON_FPU(x) ({ (void)(x); 0; })
+# define WARN_ON_FPU(x) ({ BUILD_BUG_ON_INVALID(x); 0; })
 #endif
 
 /* Used in init.c */

