Return-Path: <linux-tip-commits+bounces-6087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14120B0215C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63E15C52A3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC22F2C66;
	Fri, 11 Jul 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRLYLvqZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yp/T6rKb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0F2F2737;
	Fri, 11 Jul 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250185; cv=none; b=UFaSw726eUF+4XcpT19NgSkRBUekYPqCK5f5QQdToX5yTzTnvGd25ykLHkb94z7BHd7Pfw/A7oajDhRALKdsBPGycRobcUGd6aCu8YjS8+p4OamHZ9xAzlMK/PoHrSTAD3fStLFt1V2IjJLqk0AtqWNW27t7vUSXIi0hYi0xWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250185; c=relaxed/simple;
	bh=/HgGY1VMNMUnxJLfbEU1mdYYtayDHCUyf13iCY7vsO0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qLSLmSzPL5tE22GXKzUiLDw3zF9yYx+uyqoMiI9PdsDtNDFpZeQBQTuYA59uOQJL1yOPxGElw7K77Dw9tvwcfjUk4YKGQD4t+S7w0l8bMixja8iN6dUk/zQjVTHczGDbMp2SF5jsGovQ9DjYafJjjdZV1mBquQm+7ZZScqduS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRLYLvqZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yp/T6rKb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JslUfn/4eklkKzdWUfP1i7HrW2W00whGvJLWKXSFxd4=;
	b=XRLYLvqZ8HOK9aosL6emGpjYp7R2Q4TzBjzzvq2OWGUdva32ujBiFX6VDBEoLW/djJZCit
	WIjxF8jVI0CNOJBHtq80WuD7LkgOqshL5k9OIwRLvjFo/xtt+NfMjUKtWgTUYBleVQ0/dC
	iLMYroLXAR2i/87+kl2+0lWPixBJTirt51P6iFY+eS2pThx3jLpqpQwyQmHwe7l/0WsLc2
	DRhxrwtRDbe/1W7I2JH8xqWKP5FObJJM9GWDlpVFXXpSyG5YgOgff3HY3Wy+Lg44NCiG8l
	t3d0oFSFkylFuvX/H5q8p8bBc1HN4pShmP5F5ZZwEKpFosV5iT84B2oNMi6dpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JslUfn/4eklkKzdWUfP1i7HrW2W00whGvJLWKXSFxd4=;
	b=yp/T6rKbqcpTWmb1DrkQpNIUHMN3I9zQ74Ww+f+K95GtAxdRO8quGI9sA4kadNbQXOe2ef
	17qVPw68wDkHRTBw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for RFDS
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-9-david.kaplan@amd.com>
References: <20250707183316.1349127-9-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225018061.406.7548749218244696205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     54b53dca650bb273655a9a9b5a5b5a3fced0bcc1
Gitweb:        https://git.kernel.org/tip/54b53dca650bb273655a9a9b5a5b5a3fced0bcc1
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:03 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:40 +02:00

x86/bugs: Add attack vector controls for RFDS

Use attack vector controls to determine if RFDS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-9-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 39ff556..a557d17 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -748,13 +748,17 @@ static inline bool __init verw_clears_cpu_reg_file(void)
 
 static void __init rfds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_RFDS)) {
 		rfds_mitigation = RFDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
-		rfds_mitigation = RFDS_MITIGATION_VERW;
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_RFDS))
+			rfds_mitigation = RFDS_MITIGATION_VERW;
+		else
+			rfds_mitigation = RFDS_MITIGATION_OFF;
+	}
 
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
@@ -765,7 +769,7 @@ static void __init rfds_select_mitigation(void)
 
 static void __init rfds_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		return;
 
 	if (verw_clear_cpu_buf_mitigation_selected)

