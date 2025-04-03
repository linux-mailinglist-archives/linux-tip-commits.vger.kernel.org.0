Return-Path: <linux-tip-commits+bounces-4650-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E71A7A4AE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8353A9597
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96D517BB6;
	Thu,  3 Apr 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AL5GMl90";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLFi43uj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73F2E3386;
	Thu,  3 Apr 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689257; cv=none; b=LJLfwYNdGJi02L4sEnr0ZjQEX+jMl+L1TnJJO0uZXWeaFf/avf090P65S48QkjJilq9e+qor9DQ/2l6vft5+oX8DTPh5Bf0umXpPlLo9RwR86AqKGaLpcaJrTi6D+DMFLbyFstrg9LXuycLadmZFrAdBhORH39hfLyJTjqfLfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689257; c=relaxed/simple;
	bh=8s4A2K6DtKTXPaidr/W8po0kcjbCFGNHHLzHHeZ95D0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hSmi4y7+4XkmId4s3deo3Nwcwoa/vbmPTIhS9QQtm3yKDZa2bFohJ9kKGDFygH1UpK7wojZeKP/hMZd+zKb0Ze+LzhauW/l7+JpqR8JwxIhbSgVgkCfSanTTfyp4FwgzC+hNPIiuOdcGkw8TC2D2AY7GWCCRb8jOvreGcglg4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AL5GMl90; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLFi43uj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 14:07:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743689254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUnj0gmpXKjbhVIlMyROvWTiPybkNsz/9J+M2CSKxTA=;
	b=AL5GMl90zlMJud8x+7fo1EEeULYp6t8sR/dF75S9WTEk89DTmZD1wfDv5q+j33g9y2fUoR
	R5vayAw7d0DsWpSbTY19WibTEIrG/ePxeEhq3TVJJ2J6ue5+5NVfsY01a7T774Gz+mXJgH
	GcDUJL7EjaCm7Wuj966n/xUURwGyfNvOQb+9HxK0utUwujXezrhivutZD5JT9DP5AbZxdf
	ETerB4uv91Zjh2NtaNcTbNziyRmlKHVcWoblg2ja4pfMwR8e28LLbcS3m69zoEWHtwFoi1
	IfHXmMRcbmkTMHs29PMxOTR9DtCVupO8hWGJAPRfhdQvfEqHdNrXijjRN60vWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743689254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUnj0gmpXKjbhVIlMyROvWTiPybkNsz/9J+M2CSKxTA=;
	b=nLFi43ujNnicJsJ9e+g392sP2P4XHB2U56C1CMcw9O3p3DvLfT4oew6r2B+8hhSNLQY0by
	6fzvbo60UKhwVFDQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/idle: Change arguments of mwait_idle_with_hints() to u32
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250403073105.245987-1-ubizjak@gmail.com>
References: <20250403073105.245987-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368925045.31282.17963073191703372905.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     532aa71ed23b79e74171de7b6b6369a08b55c813
Gitweb:        https://git.kernel.org/tip/532aa71ed23b79e74171de7b6b6369a08b55c813
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 03 Apr 2025 09:30:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 15:40:43 +02:00

x86/idle: Change arguments of mwait_idle_with_hints() to u32

All functions in mwait_idle_with_hints() cast eax and ecx arguments
to u32. Propagate argument type to the enclosing function.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250403073105.245987-1-ubizjak@gmail.com
---
 arch/x86/include/asm/mwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 26b68ee..5122260 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -109,7 +109,7 @@ static __always_inline void __sti_mwait(u32 eax, u32 ecx)
  * New with Core Duo processors, MWAIT can take some hints based on CPU
  * capability.
  */
-static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
+static __always_inline void mwait_idle_with_hints(u32 eax, u32 ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
 		const void *addr = &current_thread_info()->flags;

