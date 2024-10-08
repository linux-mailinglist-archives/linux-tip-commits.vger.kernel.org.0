Return-Path: <linux-tip-commits+bounces-2384-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE2A99576A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 21:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB471F2577F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A037721263C;
	Tue,  8 Oct 2024 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Itm35YcE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AJYdrgjb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3D1E0DFB;
	Tue,  8 Oct 2024 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414603; cv=none; b=NT+OfeDGdTns7AhA69tZXqi74JE/MmkTc8ADFN2amPIzw8xiqBi0vXi21AdKuZawjIskFWchZGc97rPLkaJ32WO+3F8GkjvjIbSD5KGT4t1L7gxFZwvzda6LTeISeavP1M5ZTu76eSyTkbLp0NH0DMuREGdSuF/8hy0Jh/Htksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414603; c=relaxed/simple;
	bh=eVFXChcSE1y5iVt9xbcGXm04MsrQ7CLHg40eTmq/7UA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C3dlsH2C4Rq0wg85MmotsfroL8YJCSVicql1aSL/Vw1EpVqwVeAlnLTOIGodF6B2cF+HOQ1G0L+8u1mfemFPpjTOfP3tcX2riPsr1ztKcttCoKfE3dpAt6lxLgzg/KDbDqsWM9Lz/zPb2xmU2yufDOhbWfPgHIJN/HNcE3UwZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Itm35YcE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AJYdrgjb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 19:09:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728414599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxaBzUMQAsZ7cehIe5i1n1s+VKKhw+DeEzQzMhn6iTc=;
	b=Itm35YcE/kx30WtZYlQp+xvbatidj4tKV/L+Lii/qZTV5bxHRtC1LDh/sZw0bHIZOwO8p1
	QGYB2DaSP4Tqc/DT4eRjAPsj58LhLY+TYKTQkuzfPnyyY5TvtXZhXlhtoFQlUw+WxwbDEo
	OK/J2FwvMTXavzF0p6L4DyKOcA6ttOW+rQxTR7mEloUmf7AqsMI5MVX6Nl9XhTudjSMhfV
	3KYkHU5FbJ4VYulOYqf7+xtTSxX+k46qwgewCdzXg2Svuw7jT7GXsurV6Unt6M/TUoOxfn
	7Ea+uGtFlGu2Q8KLCvXs545aBHncby2Ygxax5bf6wLeiFXcmir+XiSmBpGwqFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728414599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxaBzUMQAsZ7cehIe5i1n1s+VKKhw+DeEzQzMhn6iTc=;
	b=AJYdrgjb3trK0qIYriLTk7e/kA0i/1F3Ft2T8GswhbPfy5SQDeKF2k7gkGGFMzsYwN67eS
	QJY2HAz5b+t10pCw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/resctrl: Annotate get_mem_config() functions as __init
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>,  <stable@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240917-x86-restctrl-get=5Fmem=5Fconfig=5Fintel-i?=
 =?utf-8?q?nit-v3-1-10d521256284=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C20240917-x86-restctrl-get=5Fmem=5Fconfig=5Fintel-in?=
 =?utf-8?q?it-v3-1-10d521256284=40kernel=2Eorg=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172841459857.1442.1559612433807217622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d5fd042bf4cfb557981d65628e1779a492cd8cfa
Gitweb:        https://git.kernel.org/tip/d5fd042bf4cfb557981d65628e1779a492cd8cfa
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Tue, 17 Sep 2024 09:02:53 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Oct 2024 21:05:10 +02:00

x86/resctrl: Annotate get_mem_config() functions as __init

After a recent LLVM change [1] that deduces __cold on functions that only call
cold code (such as __init functions), there is a section mismatch warning from
__get_mem_config_intel(), which got moved to .text.unlikely. as a result of
that optimization:

  WARNING: modpost: vmlinux: section mismatch in reference: \
  __get_mem_config_intel+0x77 (section: .text.unlikely.) -> thread_throttle_mode_init (section: .init.text)

Mark __get_mem_config_intel() as __init as well since it is only called
from __init code, which clears up the warning.

While __rdt_get_mem_config_amd() does not exhibit a warning because it
does not call any __init code, it is a similar function that is only
called from __init code like __get_mem_config_intel(), so mark it __init
as well to keep the code symmetrical.

CONFIG_SECTION_MISMATCH_WARN_ONLY=n would turn this into a fatal error.

Fixes: 05b93417ce5b ("x86/intel_rdt/mba: Add primary support for Memory Bandwidth Allocation (MBA)")
Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: <stable@kernel.org>
Link: https://github.com/llvm/llvm-project/commit/6b11573b8c5e3d36beee099dbe7347c2a007bf53 [1]
Link: https://lore.kernel.org/r/20240917-x86-restctrl-get_mem_config_intel-init-v3-1-10d521256284@kernel.org
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8591d53..b681c2e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -207,7 +207,7 @@ static inline bool rdt_get_mb_table(struct rdt_resource *r)
 	return false;
 }
 
-static bool __get_mem_config_intel(struct rdt_resource *r)
+static __init bool __get_mem_config_intel(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_3_eax eax;
@@ -241,7 +241,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	return true;
 }
 
-static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
+static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	u32 eax, ebx, ecx, edx, subleaf;

