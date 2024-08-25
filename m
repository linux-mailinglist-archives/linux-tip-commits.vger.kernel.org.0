Return-Path: <linux-tip-commits+bounces-2106-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CC95E356
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717211C20A93
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8D153BD9;
	Sun, 25 Aug 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6RcErxS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qfg6+GZ8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93905464E;
	Sun, 25 Aug 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589435; cv=none; b=eWhNojkCD3qEPxjWxhReIZVtQYe41hajzglSQ+Q7z0LNgdDdQjYopyDe9aQEEMWK8e/dvtVrije4xaA7jvATRFdCl5gy4bHWGSJ/dvaq8aVTmmHPiaYpxXQW4DKh/QjDywwd9Te1DDijUxdrenAHU1KLsuZgOIB/XDPNSQPBr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589435; c=relaxed/simple;
	bh=R2h7LBOsIWEuUm8sARlQoRB3DoMR73KlxK33Uhd1It0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Syp3WHF8sd6Dfk6ndsZZ7jD85B7/aphe8/L6LySYwip6HeoAmUeCwx3UhQJ/0ZpC/jLJLc5hseDIqzbMcbYBxKkgQbO9pld0mPpOEIzNqNYQ/niLSRg9oRbZvNEqqUZ9NxAC3heZ2mY3igFAu9WIWvSas3NUrytmrHd6MBHqEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6RcErxS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qfg6+GZ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 12:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdq+csEPlgPOAqV87tgQJsYMzQxOIe/xTQu42OObkHM=;
	b=z6RcErxSCmowxFt84UKyJ+cRu1DELqN9VZ3HydNlKM+Xr5k+iZuf4OhJKYbzJhaOQbJaXd
	rD6WMNjnwZkTEC+hdXgT+T3dyMyaSgV2Wa16wCqiRib4Y4ZdjL/+W6LWl18RXtxvebwJRu
	nZo99Vv+dCbxN0rhaoo6pxctBHQOqiCZ6NB0d5gBLkEoMQP32nKxSQdb4CGUKDm+a4gEQ/
	6hUvuuUf93luaqGp5Qnzdl2cd/Yq4V083Mvg9YNUrG63ZcsiuwB9DIkrrqw4V7aOwBll3g
	aweqLEGpst+7iWqKyyDSEv8bWngN3xyWpJGSIYnNu2ZpSfJO5P5/8fzBynVJ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdq+csEPlgPOAqV87tgQJsYMzQxOIe/xTQu42OObkHM=;
	b=qfg6+GZ8T3pGxAPVCCdGVrspo5Gy95iR6RYggiNfaoUqycqXRK8nCG9aXqnN6P/PLfPHxw
	jIjYsg9B56pL0+BQ==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/sgx: Fix a W=1 build warning in function comment
Cc: Kai Huang <kai.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240825080649.145250-1-kai.huang@intel.com>
References: <20240825080649.145250-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172458943182.2215.2311081873541283986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c6e6a3c1698a86bacf7eac256b0f1215a3616dc7
Gitweb:        https://git.kernel.org/tip/c6e6a3c1698a86bacf7eac256b0f1215a3616dc7
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 25 Aug 2024 20:06:49 +12:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 14:29:38 +02:00

x86/sgx: Fix a W=1 build warning in function comment

Building the SGX code with W=1 generates below warning:

  arch/x86/kernel/cpu/sgx/main.c:741: warning: Function parameter or
  struct member 'low' not described in 'sgx_calc_section_metric'
  arch/x86/kernel/cpu/sgx/main.c:741: warning: Function parameter or
  struct member 'high' not described in 'sgx_calc_section_metric'
  ...

The function sgx_calc_section_metric() is a simple helper which is only
used in sgx/main.c.  There's no need to use kernel-doc style comment for
it.

Downgrade to a normal comment.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240825080649.145250-1-kai.huang@intel.com

---
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 27892e5..1a000ac 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -732,7 +732,7 @@ out:
 	return 0;
 }
 
-/**
+/*
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
  * metric.

