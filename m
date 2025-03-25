Return-Path: <linux-tip-commits+bounces-4469-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B283A6EC1D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5013D188EDBD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93D1EB5F4;
	Tue, 25 Mar 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BcWzkSb+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gv5yrc2c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65D1DB924;
	Tue, 25 Mar 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893535; cv=none; b=imhpHWzdUs1vPrZJKkmVELcKFiyUBaPYl7P7iIfUEX5YF96BNv/yB72Ez60TE15zDzeew/s+serU/wUojjg6VTPKYWLF1ViR4AJL6ibSGboI/FNFVOgJwgydBMMt1+4cAWMGPJAKIF7OD/9B3Iqj3K24M6OlVdvpPc89nA0/ygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893535; c=relaxed/simple;
	bh=2mZQ7eml4aJSdGbpJbfitP/Yvp9hnXXNUy8JViDNcjQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WJfoxperh5kGrhMG6Ytb4lG3KSKQCQhRsuPhseFDWJ8Z8HWrFWlAnsxtxAvZ1MMqEPKfEGiu71Z1vh9UgJIpKVxU2UlHHpbZPHzh+xuFb8KEzeI2X1d8wvthBUHwCnI/1tsQl1D2AoXjMk9D7V1WLjyyvx7ochs39II+949apaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BcWzkSb+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gv5yrc2c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwS5BZJVrPYqrllrrYgEvZ20Y0teizAYO1OMHyrrdlQ=;
	b=BcWzkSb+L1zFjr7CFaQ477mMI9dN/M8RZZ8RbTlj/3A9Pwq4DVV7ZUwbNGlexV2+unbKzI
	Bz1zwUyueJfsA+3KnQ2StdYHFSjJTOZjWhwGw4f1lM/oPEW4trWK5CYHWXrWXUCIzcPpJD
	ZwBeaTziXi0agO4ukQnAcUWCZ4pDFIrG4tTvK0qFiZgX07vsaOck/DBkAPCZbflwGI5iO6
	6bg+KY21+T7PP1nnD8kiRHeqHQ3v0fV11ELA7hgKn3MrXA5+U58UbKZL2VoUUKcJf9bR83
	uC1tpq6XQq9WP4lgjp/zNuU1s0vpDScieW2y/BSsXCTl1Prns7KsGrdHC+0SPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwS5BZJVrPYqrllrrYgEvZ20Y0teizAYO1OMHyrrdlQ=;
	b=gv5yrc2cuOPBDHhlnluVer4oCtI9YntvkZCMpnmFjU5PM2CsOA66kGVvUSwHyvccY0ha2T
	wjG9nEbHFPPwKjAA==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Update the outdated comment above
 fpstate_init_user()
Cc: Chao Gao <chao.gao@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250324131931.2097905-1-chao.gao@intel.com>
References: <20250324131931.2097905-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353097.14745.8046261467054933524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     878477a5953769d4fe5facc5033481f81d0dfce7
Gitweb:        https://git.kernel.org/tip/878477a5953769d4fe5facc5033481f81d0dfce7
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Mon, 24 Mar 2025 21:19:27 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:57:33 +01:00

x86/fpu: Update the outdated comment above fpstate_init_user()

fpu_init_fpstate_user() was removed in:

  commit 582b01b6ab27 ("x86/fpu: Remove old KVM FPU interface").

Update that comment to accurately reflect the current state regarding its
callers.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250324131931.2097905-1-chao.gao@intel.com
---
 arch/x86/kernel/fpu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1b734a9..91d6341 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -508,7 +508,7 @@ static inline void fpstate_init_fstate(struct fpstate *fpstate)
 /*
  * Used in two places:
  * 1) Early boot to setup init_fpstate for non XSAVE systems
- * 2) fpu_init_fpstate_user() which is invoked from KVM
+ * 2) fpu_alloc_guest_fpstate() which is invoked from KVM
  */
 void fpstate_init_user(struct fpstate *fpstate)
 {

