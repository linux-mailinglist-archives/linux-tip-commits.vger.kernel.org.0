Return-Path: <linux-tip-commits+bounces-4640-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24EA7A3C5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE50318963F8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05724EF9C;
	Thu,  3 Apr 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KldrD3fF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SGcMVzGL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF524E4DA;
	Thu,  3 Apr 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687223; cv=none; b=OUVH99CYOpjhQbmD/wAVoIOosc8u0ZhK5Tzi4rwQoXyrNMoTuTULsKFrqNwNIneAuJhcNZMr3VbHzjgfLcSAFk9nv6F90RdltX+GnNdOyLmvjRLepItkDW5wddsyqV/CncvnMI44+4hQhk3vZ3tWlqmn1opQVqoncIDI4bG5780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687223; c=relaxed/simple;
	bh=0aWnYGk8h5coIQuXtcaBkxMjAjuILuNGwmlpr1Z2ZX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mwj/BdvKUbWoSJMR93jjLOEJtT16mzM/SKxGxq9oBgjFJhIVKe75NdO11fIB6380EsLmUOgQg0qUrI7A/v6pKU9m1eRC8rSsPTfyc4IHPRtME5wqDFSWF2qOgG89QpnSjzANnb58zU6WlkAvG/pQLjp3FyY1DOVCcS+ahX4fhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KldrD3fF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SGcMVzGL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Cx0X9eRHEM00epeXjUzcRh3IWgYrlzDwr6EsgY59e8=;
	b=KldrD3fFeW2UrRM12f/R6pHrZc86NwhHiZHZq98ImUEo6dOCTvfQ2wWt0lNssGiMNQ0pXI
	5DAm04qj6yST1V2XMb1QphUpFW9uQy8cmarGof0z28uTBjRyvftN0gi16aUSh2yqNthuQB
	1LQqGHEuP0VXhszs18WDhin+Zyb0agwy1AYYWfY7YWAYnomlCEJQ4/gxWUfYxueXXqrtLg
	BHTZh6Kfz4J2K/C5e9hPPX1Yh/nWn2euLwA4ssCAzhOj8ML2nRCkVtVM8xcqqb7xTs16yO
	6VdyRgFmaNgIUeiTHkIeb54Fb7uB5dkEdwm9s8QNf7USwCqLHdBWOcoPsp00lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Cx0X9eRHEM00epeXjUzcRh3IWgYrlzDwr6EsgY59e8=;
	b=SGcMVzGLKBsInoU8FeczH5THL8fQWwbu11OHDyAySskClXZ5TX1+tu3Xyoorwvd/KuUa2f
	/Us08OID1jF6gsCw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Add missing description
 x86_platform_ops::get_nmi_reason to <asm/x86_init.h>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-8-sohil.mehta@intel.com>
References: <20250327234629.3953536-8-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368721942.30396.16916644994174562031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     7324d7de7740fdbb29c79f5e2a001524370fa732
Gitweb:        https://git.kernel.org/tip/7324d7de7740fdbb29c79f5e2a001524370fa732
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:27 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:27 +02:00

x86/nmi: Add missing description x86_platform_ops::get_nmi_reason to <asm/x86_init.h>

[ mingo: Split off from another patch. ]

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-8-sohil.mehta@intel.com
---
 arch/x86/include/asm/x86_init.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 213cf53..36698cc 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -292,6 +292,7 @@ struct x86_hyper_runtime {
  * @set_wallclock:		set time back to HW clock
  * @is_untracked_pat_range	exclude from PAT logic
  * @nmi_init			enable NMI on cpus
+ * @get_nmi_reason		get the reason an NMI was received
  * @save_sched_clock_state:	save state for sched_clock() on suspend
  * @restore_sched_clock_state:	restore state for sched_clock() on resume
  * @apic_post_init:		adjust apic if needed

