Return-Path: <linux-tip-commits+bounces-3337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A4A299B5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 20:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6D5169E53
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB3C1FF1B3;
	Wed,  5 Feb 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="db+Oljvv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugIDKPGR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C71FECB5;
	Wed,  5 Feb 2025 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782455; cv=none; b=shtczr3MNG9kQFangziXxJQCfC0Xl7nCiqkmwDlDA2qVmbpK0ys/9HBR29/lzvkl4AJhz4tXyUsBxvvZb3Ht10mi/+TMVJdB/RFlZO04RHaL52eIZ423DnfWOOdd3dt3zLWiR1H3SJhUC+61loUn3C5K6IwLI2mXuJa6Fkj1bj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782455; c=relaxed/simple;
	bh=2KTk+SomB+UKnp9dki04xZOGUOi+8hXxABZ9dn5trIo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=a84mrBUieb+OdDeBl2d6qdSuAn353mjObpZVK0jrTYxTyRLEf4cBiyCKo06Ug+J7XdnUWS8ZO5vPvm3iT40/J2OXZcFPDXphY3MYZot6Do2UBn7KWivtnckVTF+dQU4sNIfvCJtEEps6hPvjXIvAUtyImmyBYjwFgulfMUKR6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=db+Oljvv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugIDKPGR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 19:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738782452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1ej9NTfHsy8NTBFABSXCMYATIbXQa2pgKtDvB07INXU=;
	b=db+OljvvgTSmNbN1obwmPMSgIyZrHACMSQXMylbNDM07ONfh5m3gNjwP8q5zvUDbkcv9DJ
	bhJ/WMVs2vd1rpXRmoU35B6BhcsQejV5ZuAedigOuCwkSmDXqC4ADcpVoDXGGwP7kazZMK
	rFI2uofxnFh7ssIfbOCVtf/P1Y+O/Ol/J8P3qiAKnXLZQdA8o6M73/4Rm4ZHBiXSSZ1vj0
	OKa+9UKR+8p01etjMmCV2JYby3Cn5oUDBfP3LCZkBzw7lQ+3UaOvq8JrmSCA96PwEHBVr0
	JjC97HuhnLvnU6GKF/f01Giv4izME1dCy/2mpo1UP5D4gnzTeXjJSVEjuvC6IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738782452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1ej9NTfHsy8NTBFABSXCMYATIbXQa2pgKtDvB07INXU=;
	b=ugIDKPGRetUIepxvyL9zOfcWIgaG1HbRH14TqlFwD2Y43IzwAZWTZd/MhHt6Hr78fD9El6
	0dH8RvbS6UhSieBg==
From: "tip-bot2 for Patryk Wlazlyn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] intel_idle: Provide the default enter_dead() handler
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173878245161.10177.2550267558248519658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fc4ca9537bc4e3141ba7e058700369ea242703df
Gitweb:        https://git.kernel.org/tip/fc4ca9537bc4e3141ba7e058700369ea242703df
Author:        Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
AuthorDate:    Wed, 05 Feb 2025 17:52:10 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 05 Feb 2025 10:44:52 -08:00

intel_idle: Provide the default enter_dead() handler

Recent Intel platforms require idle driver to provide information about
the MWAIT hint used to enter the deepest idle state in the play_dead
code.

Provide the default enter_dead() handler for all of the platforms and
allow overwriting with a custom handler for each platform if needed.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20250205155211.329780-4-artem.bityutskiy%40linux.intel.com
---
 drivers/idle/intel_idle.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d..e59073e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -57,6 +57,7 @@
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
+#include <asm/smp.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -228,6 +229,15 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+static void intel_idle_enter_dead(struct cpuidle_device *dev, int index)
+{
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	struct cpuidle_state *state = &drv->states[index];
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	mwait_play_dead(eax);
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -1800,6 +1810,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
 		state->enter = intel_idle;
+		state->enter_dead = intel_idle_enter_dead;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
 }
@@ -2149,6 +2160,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		    !cpuidle_state_table[cstate].enter_s2idle)
 			break;
 
+		if (!cpuidle_state_table[cstate].enter_dead)
+			cpuidle_state_table[cstate].enter_dead = intel_idle_enter_dead;
+
 		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
 			pr_debug("state %s is disabled\n",

