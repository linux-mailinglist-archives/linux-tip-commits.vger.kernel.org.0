Return-Path: <linux-tip-commits+bounces-6283-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA429B2BCB5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Aug 2025 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A623A6748
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Aug 2025 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21231A06D;
	Tue, 19 Aug 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oM/E5tg6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DjN5x7Y1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64287315781;
	Tue, 19 Aug 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594708; cv=none; b=g08t/7NNpEnS2OXy/m+2eVTMXVoBAU8rMmaI5OgBY2ErLswVeDgXOWj+fSyTXsEsg+A/rbnYpWZY05PBwXoYZo3wYxA1pAoN8fzg4I0z8LN4tTI/w3TQIkFLJCnG/0TTvsRPbhQ/ajrHLH5GIHCuX9sMOVcb/P/rvdZ3+4ybK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594708; c=relaxed/simple;
	bh=wTLgXyFErwbqAmB1GzUKHOaEqggvrPIkBrMSoBmmeyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=siTD+t8f3URk9BNXrN5M2YvREtJKfTZ4S2bmxwxP8RGIlZzVZzqEYj6FQwXP7ZbAfPUUU0vz+YN3Yy6h0Ar4VyJtW2XsdhXC5r0ZTCdawkm2d3A7bgi9XcQxw9nxq7yxisF/BNLGNUwg2YEw6oIJ0Dj9tNCv+jpfFmbVAXTdPNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oM/E5tg6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DjN5x7Y1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 09:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755594704;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1xcSsbomoZtPMZ82+TU5MaT+ilF/IjvCyLG26neCmU=;
	b=oM/E5tg6U466D6RplaJkrIdd/ZioHRDNeh6OACxjW6C+Y2DROZhg8Bn3pGDvu3j51YZkND
	9ZqTMashlH3HQRccOSRJ5D1blfFkzclRkTmYEmVTd5E2PbPky7omB1IJmCIokjtPhlV84F
	libC4Vn5Y6kiz/sMTTTef22j5ZpMkEwQRFOS8UdO3xHxeLosY+kXg99l1G+gKoRHji9S+h
	w/0hjbgzGPqj4xkYiZ71DfFphS2oNzafd02d166hSPH97ptDMGG7tLOoFxYrk6/INYjn3e
	z4uR1QFNCukIEvpvsbGZP0GwkO1ZSQCu8dV8sRxYdpWYrChaVX3rx1sYca9zcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755594704;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1xcSsbomoZtPMZ82+TU5MaT+ilF/IjvCyLG26neCmU=;
	b=DjN5x7Y1rc+ofTCD/8A87rNwR44L4ap6E/ocXcPw6LtAgRxzh2Dl/06tI5t3IYNB1/Qlaa
	s6zAMqnWboXTLeCQ==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Fix GDS mitigation selecting when
 mitigation is off
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Li RongQing <lirongqing@baidu.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250819023356.2012-1-lirongqing@baidu.com>
References: <20250819023356.2012-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175559470048.1420.1064883565288738803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d4932a1b148bb6121121e56bad312c4339042d70
Gitweb:        https://git.kernel.org/tip/d4932a1b148bb6121121e56bad312c43390=
42d70
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Tue, 19 Aug 2025 10:33:56 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 19 Aug 2025 10:38:04 +02:00

x86/bugs: Fix GDS mitigation selecting when mitigation is off

The current GDS mitigation logic incorrectly returns early when the
attack vector mitigation is turned off, which leads to two problems:

1. CPUs without ARCH_CAP_GDS_CTRL support are incorrectly marked with
   GDS_MITIGATION_OFF when they should be marked as
   GDS_MITIGATION_UCODE_NEEDED.

2. The mitigation state checks and locking verification that follow are
   skipped, which means:
   - fail to detect if the mitigation was locked
   - miss the warning when trying to disable a locked mitigation

Remove the early return to ensure proper mitigation state handling. This
allows:
- Proper mitigation classification for non-ARCH_CAP_GDS_CTRL CPUs
- Complete mitigation state verification

This also addresses the failed MSR 0x123 write attempt at boot on
non-ARCH_CAP_GDS_CTRL CPUs:

  unchecked MSR access error: WRMSR to 0x123 (tried to write 0x00000000000000=
10) at rIP: ... (update_gds_msr)
  Call Trace:
   identify_secondary_cpu
   start_secondary
   common_startup_64
   WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/bugs.c:1053 update_gds_msr

  [ bp: Massage, zap superfluous braces. ]

Fixes: 8c7261abcb7ad ("x86/bugs: Add attack vector controls for GDS")
Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/20250819023356.2012-1-lirongqing@baidu.com
---
 arch/x86/kernel/cpu/bugs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2186a77..49ef1b8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1068,10 +1068,8 @@ static void __init gds_select_mitigation(void)
 	if (gds_mitigation =3D=3D GDS_MITIGATION_AUTO) {
 		if (should_mitigate_vuln(X86_BUG_GDS))
 			gds_mitigation =3D GDS_MITIGATION_FULL;
-		else {
+		else
 			gds_mitigation =3D GDS_MITIGATION_OFF;
-			return;
-		}
 	}
=20
 	/* No microcode */

