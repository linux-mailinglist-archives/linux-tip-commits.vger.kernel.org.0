Return-Path: <linux-tip-commits+bounces-4376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82524A68B10
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94931B626A1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119C25E46E;
	Wed, 19 Mar 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHPmlI1b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2TJdjY2N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDF25DB18;
	Wed, 19 Mar 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382242; cv=none; b=mK4b6aapPXzpxlMd113cGTg/OenwQ2IPx04qMycuaHuRtu6axyU5OZgJjyOf/RDkLFNfSIDMv++SB5zDPYlBrKJLVu4R8Qo+a7u7MxJV+SRvb0zvWvKwi/QIAH9mF0jM/CatdNcsRJm9UXTPXu7Fs51agJfghcE3pv30OhW0QFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382242; c=relaxed/simple;
	bh=Xv7GIb8zj/K5wKfcqjX9AU85H2HhV+uZBJZ6A303Qrs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JtfGDxM0xvRuZ/BFfZ+EgRWk8+J9uwKjWhu+kt2+oK8ic1Rs0/sM0N6wHb/1pzBRFMAWO7qJVp3KCPMiomUnkhggdwc3mHFIFLjATVLd4xjml1C+wTVAw75JKyb4UdWVbcYRj2FaAgOAPOTCu4Aw166VVVYvM6WUCO1GYEva4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHPmlI1b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2TJdjY2N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCP9bTbPar9kenkqOBtDMS9xeNK5rldVg4JUNeI5hr4=;
	b=AHPmlI1bfLcSsPVx3OpP7UHYUrZfOTvVByIvcBMiV4KipmvJQEHTv8gNhHB/yhEA+fqDIR
	/7lKSmFdvM1X7u3jeo2TtIQh8cD0b2GrQhP+QqMY/BvP8yQ7VJybpL08DbTdGmAIUL5edc
	9fHXgWqqkCbAkPDZDcX0/XJo8M2cfF6mXCMdEFej/o88dHbnfERgwh0hphjdeCxsVNviUN
	0WqMrryziyB7rmsf3hSsWrt1pYXGKom20neCVaMqe7+6oPLOmjc0b0BrPVIgk2jijIyB09
	29ON+z47lrmrqk0AGN+E3j3EZNJ03q4/MB7xwUaGg29A+A5Vg11RBOkZPyI1Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCP9bTbPar9kenkqOBtDMS9xeNK5rldVg4JUNeI5hr4=;
	b=2TJdjY2NoQcvZjwDfRQ8/HNBYb1lokwyRXypXb+sRGnPz/Bkp/+OGdmVY9bVo9otwGnmrt
	ugK4FuEVBfrBRrAw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Fix the description of X86_MATCH_VFM_STEPS()
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250311-add-cpu-type-v8-1-e8514dcaaff2@linux.intel.com>
References: <20250311-add-cpu-type-v8-1-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223784.14745.2063277713363886874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7b9b54e23a677efdc76220903afa4262069a5dc7
Gitweb:        https://git.kernel.org/tip/7b9b54e23a677efdc76220903afa4262069a5dc7
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:02:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:16:33 +01:00

x86/cpu: Fix the description of X86_MATCH_VFM_STEPS()

The comments needs to reflect an implementation change.

No functional change.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250311-add-cpu-type-v8-1-e8514dcaaff2@linux.intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index ba32e0f..9ebc263 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -209,9 +209,11 @@
 
 #define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
- * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
+ * X86_MATCH_VFM_STEPS - Match encoded vendor/family/model and steppings
+ *			 range.
  * @vfm:	Encoded 8-bits each for vendor, family, model
- * @steppings:	Bitmask of steppings to match
+ * @min_step:	Lowest stepping number to match
+ * @max_step:	Highest stepping number to match
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.

