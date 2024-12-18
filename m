Return-Path: <linux-tip-commits+bounces-3081-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8969F5C04
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 02:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E911893601
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034B7F48C;
	Wed, 18 Dec 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DljyZSaK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAfZGWFJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36759433BC;
	Wed, 18 Dec 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483620; cv=none; b=h0/Cgy13hJ+WuK+ji6CG/9BXTvjIFExKysuACj1kZ+AEPdIbKRyVWjieKqkIQzyLPt7sqYvMleUDtg5k2CR4rqz6+O3nI3pf0WxNyJK+EVb3OuZFNlU9yR7vze+Nc4RrDPP4p6nvefwRoAu7uD2wkVUNbdTwGxdelEy0Sy6mWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483620; c=relaxed/simple;
	bh=0SGD1fFjn4akT+ZBI9e8WucGx2VdZUVYt+npWT3a0Qs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LSq1Vpg+vNKpy8h4uY1fnpS1fhTYpQNrmaYdHxg0s5Gi9VqKMSlZjKpKTDQsvn6eIq4K46TycKfPvh8piW5rZyS2YzkJvoeZkFTRDKsp1+ghkgr5IRobg+WX6l0ZHmHdFchSgcjetXQpu8AwxC3ZJMAzWrcR1ulGZodejdix5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DljyZSaK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAfZGWFJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 01:00:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734483615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HFcritjuNUOWs78ervQ9n0BgMdNgPmavn88bTRtVZFw=;
	b=DljyZSaKRtJXl2ktf2oAlslfSUiRr31jeKbjcX7RbsHROSq2VABdEmvdEdqmnJjhQcJ8HK
	DsGZzXUyJXn1p4x2AZVMH8VLG8rju1KuiB2BUs35EPSqwMYXqHAsOxzl6AA4KPromo0Wlr
	WnsMg/bzB+IpHA2Mt2EbjyAyGYwCZ8ehqLtuNF+A4omOTKI25KllVNcB97MZLppFyCcMco
	6Rc+UNaHiJ2fCH18jQm+onWbMKNaEomalB8NPnJuPX4VBFR9HoHbSfBwvrat2kxeN/C2jL
	SxVK+E0hY+cpor2CyGknLpGUOfakqDVXGwSIrg6Cn0cDbsoIUDEwkYeF5L0SrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734483615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HFcritjuNUOWs78ervQ9n0BgMdNgPmavn88bTRtVZFw=;
	b=LAfZGWFJcMFOkrqhWRzjJvOspQ0EVR8ZtjGHAovB2eOKjKWvyOzn/5CxILBrpsPg85yS9F
	sYRVXKCgJejfo+Bw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with
 'x86_cpu_id'
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173448361411.7135.17954234838402061639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3fa5626720c0948ce067306c4f6558d9ec86020c
Gitweb:        https://git.kernel.org/tip/3fa5626720c0948ce067306c4f6558d9ec86020c
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 10:51:31 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 17 Dec 2024 16:19:05 -08:00

x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with 'x86_cpu_id'

The 'x86_cpu_desc' and 'x86_cpu_id' structures are very similar.
Reduce duplicate infrastructure by moving the few users of
'x86_cpu_desc' to the much more common variant.

The existing X86_MATCH_VFM_STEPS() helper matches ranges of
steppings. Instead of introducing a single-stepping match function
which could get confusing when paired with the range, just use
the stepping min/max match helper and use min==max.

Note that this makes the table more vertically compact because
multiple entries like this:

       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          4, 0x00000000),
       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          5, 0x00000000),
       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          6, 0x00000000),
       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          7, 0x00000000),

can be consolidated down to a single stepping range.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241213185131.8B610039%40davehans-spike.ostc.intel.com
---
 arch/x86/events/intel/core.c | 62 ++++++++++++++---------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bb284af..cd96013 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5371,42 +5371,32 @@ static __init void intel_clovertown_quirk(void)
 	x86_pmu.pebs_constraints = NULL;
 }
 
-static const struct x86_cpu_desc isolation_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_HASWELL,		 3, 0x0000001f),
-	INTEL_CPU_DESC(INTEL_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_HASWELL_G,		 1, 0x00000015),
-	INTEL_CPU_DESC(INTEL_HASWELL_X,		 2, 0x00000037),
-	INTEL_CPU_DESC(INTEL_HASWELL_X,		 4, 0x0000000a),
-	INTEL_CPU_DESC(INTEL_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_BROADWELL_G,	 1, 0x00000014),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 2, 0x00000010),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 3, 0x07000009),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 4, 0x0f000009),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 5, 0x0e000002),
-	INTEL_CPU_DESC(INTEL_BROADWELL_X,	 1, 0x0b000014),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 3, 0x00000021),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 5, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 6, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 7, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		11, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_L,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_SKYLAKE,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		13, 0x0000004e),
+static const struct x86_cpu_id isolation_ucodes[] = {
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL,	 3,  3, 0x0000001f),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_L,	 1,  1, 0x0000001e),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_G,	 1,  1, 0x00000015),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,	 2,  2, 0x00000037),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,	 4,  4, 0x0000000a),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL,	 4,  4, 0x00000023),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_G,	 1,  1, 0x00000014),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 2,  2, 0x00000010),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 3,  3, 0x07000009),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 4,  4, 0x0f000009),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 5,  5, 0x0e000002),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_X,	 1,  1, 0x0b000014),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,	 3,  3, 0x00000021),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,	 4,  7, 0x00000000),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,	11, 11, 0x00000000),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_L,	 3,  3, 0x0000007c),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE,	 3,  3, 0x0000007c),
+	X86_MATCH_VFM_STEPS(INTEL_KABYLAKE,	 9, 13, 0x0000004e),
+	X86_MATCH_VFM_STEPS(INTEL_KABYLAKE_L,	 9, 12, 0x0000004e),
 	{}
 };
 
 static void intel_check_pebs_isolation(void)
 {
-	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
+	x86_pmu.pebs_no_isolation = !x86_match_min_microcode_rev(isolation_ucodes);
 }
 
 static __init void intel_pebs_isolation_quirk(void)
@@ -5416,16 +5406,16 @@ static __init void intel_pebs_isolation_quirk(void)
 	intel_check_pebs_isolation();
 }
 
-static const struct x86_cpu_desc pebs_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE,	7, 0x00000028),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	6, 0x00000618),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	7, 0x0000070c),
+static const struct x86_cpu_id pebs_ucodes[] = {
+	X86_MATCH_VFM_STEPS(INTEL_SANDYBRIDGE,	7, 7, 0x00000028),
+	X86_MATCH_VFM_STEPS(INTEL_SANDYBRIDGE_X,	6, 6, 0x00000618),
+	X86_MATCH_VFM_STEPS(INTEL_SANDYBRIDGE_X,	7, 7, 0x0000070c),
 	{}
 };
 
 static bool intel_snb_pebs_broken(void)
 {
-	return !x86_cpu_has_min_microcode_rev(pebs_ucodes);
+	return !x86_match_min_microcode_rev(pebs_ucodes);
 }
 
 static void intel_snb_check_microcode(void)

