Return-Path: <linux-tip-commits+bounces-1551-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2491CD97
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1E32831C3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED647D086;
	Sat, 29 Jun 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PgSSi+0s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rEaYi8g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C022331;
	Sat, 29 Jun 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719671300; cv=none; b=cRbxGhNGyVd9ZeUkhhagJW2fpeN86fk9vq0y+5qV9gxwdYnFrHT4Cw72gOEjZBzhhkKdyl8RFvlB659eBonx0Hs6pym5cmrSIkqVGjpP79WyeoEx2/+eeycXAnz96f83QMz50VwcTDGI3xtWHTakFupEhwGVZzKsaH3+ePpwF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719671300; c=relaxed/simple;
	bh=X7zZNylCN8GtJr+u7LlOatOgbbVPIKN5zLkCTBfNQ6I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eCjh//BwBfLb6OfcLHWv2/hoTEV+7maetSlIAA6FtERR57kgKXy0V8n89cbj4f/m9oOVK89A3/4E0YfEaoLNFknmstiWkc+/GICoBhQ0hZwgHd7HnujPwpQr7f/loq614C10FoBX+C1PckxUpQlxmc8QDK3T+4DrnMr7iGWL8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PgSSi+0s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rEaYi8g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 29 Jun 2024 14:28:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719671291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7Exg/rhEwPQXkcLyFUYfEsb1kegpQZgHxCy+2c2LFQ=;
	b=PgSSi+0seuL7wKSKY+nXcryP4qpjWdRBxMKHvExSF6x7f/AqvMAAqVP3ucQ9ux+2oTfjjh
	MmSTdHQowulNLXwk4rPzJU5QueQfuJWxfpJA4qY9DrSyHLZKEg0LVnUjA72OsCj4sJsvO6
	b/nuKA+sMVBqnHVnFMzhXZvEhV3fKMfwCujZjTo9t6nfLHcOlBLv9jT2WyTi4ioEh4ykL1
	XkpSqQ+3vYNnhBf1vhPEK50arcHbZdAw+bJTiL+LZ+j4WyFG4/27Ym8tkwSICaDoVoO3uy
	Hxwjm3wmbcLHVxUBiyNn+Jp2zgtVTcfWs5scEv4Ak7UoTdfpiG3cT12y/af2Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719671291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7Exg/rhEwPQXkcLyFUYfEsb1kegpQZgHxCy+2c2LFQ=;
	b=2rEaYi8gmLRI/CInt/2/Mz5Jz9bK/yC3Dzj+DIefPQQ9Kk/OPieEB5y+Gw1y/Yd2ix00uv
	EdxJDAPYsaZHOFAw==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Drop stray FAM6 check with new Intel
 CPU model defines
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240529183605.17520-1-andrew.cooper3@citrix.com>
References: <20240529183605.17520-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171967129041.2215.8478111408430544596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     34b3fc558b537bdf99644dcde539e151716f6331
Gitweb:        https://git.kernel.org/tip/34b3fc558b537bdf99644dcde539e151716f6331
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Wed, 29 May 2024 19:36:05 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 29 Jun 2024 16:10:37 +02:00

x86/cpu/intel: Drop stray FAM6 check with new Intel CPU model defines

The outer if () should have been dropped when switching to c->x86_vfm.

Fixes: 6568fc18c2f6 ("x86/cpu/intel: Switch to new Intel CPU model defines")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20240529183605.17520-1-andrew.cooper3@citrix.com
---
 arch/x86/kernel/cpu/intel.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a813089..a9ea0db 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -294,17 +294,13 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
-	if (c->x86 == 6) {
-		switch (c->x86_vfm) {
-		case INTEL_ATOM_SALTWELL_MID:
-		case INTEL_ATOM_SALTWELL_TABLET:
-		case INTEL_ATOM_SILVERMONT_MID:
-		case INTEL_ATOM_AIRMONT_NP:
-			set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
-			break;
-		default:
-			break;
-		}
+	switch (c->x86_vfm) {
+	case INTEL_ATOM_SALTWELL_MID:
+	case INTEL_ATOM_SALTWELL_TABLET:
+	case INTEL_ATOM_SILVERMONT_MID:
+	case INTEL_ATOM_AIRMONT_NP:
+		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
+		break;
 	}
 
 	/*

