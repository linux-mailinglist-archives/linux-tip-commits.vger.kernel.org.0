Return-Path: <linux-tip-commits+bounces-6083-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59085B02154
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305235C4A9E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18152F1FE3;
	Fri, 11 Jul 2025 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZpYz4nH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUmEnfLb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2762F1984;
	Fri, 11 Jul 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250180; cv=none; b=OUui0mNMTplKyKTzZE3bppwWyAtYEIL224bl1VDM8V/NHCRkIWQqodB50cTVqOKkIkgSEXytjrZj1kdoELj5mFvq+LXDGsmiKQBJrbCZV/HaOmEO9R7/XASepJ+nyw6oZq9HKeA91gSN5dBR4+2Wh+iLXlGfKy5JafC9G0uIijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250180; c=relaxed/simple;
	bh=ctD1U19rEtg0gnLOyl2Rgjz5/lIndjhB3f1oEyzZHr8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RNCk7b2dzwSICSK7gEvK3ZTFaP4y/NCQxih/m7gjyFCKfrYjr3vpURAV8E27e5D2iNs7opV3tQQHtth0bcWr/G3isbsjs98c+lVrhFPXNoeXyjX7hhBxrELVYk/TUQFeu7hf57ID5qq5cYN/BicSQgOps+5RGJagj9dqoecrMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZpYz4nH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUmEnfLb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Goap8C5HorwlzvjUg/MgrUTYlJISfFpGDGlWC0689Y=;
	b=vZpYz4nH/Z2UQMbo5pIAGsvk+bn+hkPPGo/lEeg6zKoW7I+bDVI/nyeF2AElxSe7IxgTl+
	JNo9xZhLCkf072EaWx0AulpomdnR3vniiWb/Fw4ObVdv8DOrBAT3AZVD/kpZc8uWhtqx8s
	APxUi2FyMmujL18unLwJw+TxAUYL8hN/jUqAl4oXQHY5y3g4qhgYREqKe5bj8tgWi6/kat
	0qluAnE7uvTi7rAWtMOITA+OQ1uYaPl6rjD2skrqBQ3RaEt5QCdJjDigt+FpVp96zso61y
	PjQwKClIug9oa1UrpUMyL6d6l1aFWyKDF69O1HaDUCpQFM9R6lutrAjODcKzDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Goap8C5HorwlzvjUg/MgrUTYlJISfFpGDGlWC0689Y=;
	b=FUmEnfLbI4v2W65X2fCDhq9NsS9Ab+IkxOlA4w4Jn9WO7YyTX2Zi2AEjU98jvteawMGd1P
	ClI/0ewOA0jIyGBQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Add attack vector controls for spectre_v2_user
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-14-david.kaplan@amd.com>
References: <20250707183316.1349127-14-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017627.406.11618830238065177528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     07a659edcf6eb56f7906fc415f46e3a7f37d5383
Gitweb:        https://git.kernel.org/tip/07a659edcf6eb56f7906fc415f46e3a7f37d5383
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:08 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Add attack vector controls for spectre_v2_user

Use attack vector controls to determine if spectre_v2_user mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-14-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index de6eb59..ff56251 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1817,7 +1817,7 @@ static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
+	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
 		return SPECTRE_V2_USER_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
@@ -1855,6 +1855,13 @@ static void __init spectre_v2_user_select_mitigation(void)
 		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
+		if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2_USER))
+			break;
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+		if (smt_mitigations == SMT_MITIGATIONS_OFF)
+			break;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
+		break;
 	case SPECTRE_V2_USER_CMD_PRCTL:
 		spectre_v2_user_ibpb  = SPECTRE_V2_USER_PRCTL;
 		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;

