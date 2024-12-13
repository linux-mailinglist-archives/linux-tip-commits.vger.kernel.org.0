Return-Path: <linux-tip-commits+bounces-3058-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20859F17B4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFD0163922
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087991917CD;
	Fri, 13 Dec 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgxAEgT1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hLGhKG4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7918660F;
	Fri, 13 Dec 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123759; cv=none; b=SD0OyECZY9cWh5VUuzkufyNdz6Eqyc90BgqE9f3nFhu912j/5fNSSCAUKqCTBsI7OlKW3bMzbV3TkqafUEXkjTmh4Lmbl9njE0bWOwJI7Fmsp+YRBtzm/gCicCVXs9GT4cIdGDIXNvZcw/fX4fpBIEn6eYlqxK5rYNLyFP+d6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123759; c=relaxed/simple;
	bh=X+RsphI2CiMXOjKOKzsc0ExDzLmWa0lbFxkwtfnL6vY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=riUc807Cy27M6KrTx6/XYLyWmgVs//cOkFYb2Z+dQSjMB+wfCvT2NlRr6x2IQ2ONW9dC+6ert4TsyT7taFnv/FZAcszJ/NSDfrwEGVJ6JhLUuspj9gwNsZmq2U7NanuMwfZ2eLsic9WumrU5vONaM1qwM6mncPy95bm+hGSv8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NgxAEgT1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hLGhKG4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MB2XsqUY/gqA4cgQXCB6LaONxZS6IZlzO75dyKUUP0I=;
	b=NgxAEgT1gxCD/wq10ymAEkVWW2HVH4kORpboN3vBle7qxSdTrEvndS0S2U41ZEzSrZ2DQo
	4qcmv6qH4by55hxUPXpCpv67IbJlpWWjOGZ1UcMx61FYpCwpTWtuvqpx4jUFmF//Z3hq3u
	DDPNlHxz2poZc1RPcWSdPbPwIDnKRbNhDkpOUlNK/wSQpxA/mq43WXhrtgJcVbcGScXbu/
	8YIN1eUSU6a0l6dlw7ZF6ybOSMJFpNR/kU4TG+i2vCTpifse5fE2Qi3O6r8hYALCLTbI0W
	5JtXlUSEp3qUtfO5U3cfkLsWk3tCUXnXMBGMGrnwaohNY5XZ+LO19K1XsuzHVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MB2XsqUY/gqA4cgQXCB6LaONxZS6IZlzO75dyKUUP0I=;
	b=4hLGhKG4/CII+GBZ1LvDAW4E9ErEkYIub9R4AyTMQaqTXoezWL98DxbEHS0UaWLShJjamb
	vlEqA/sw8y3ejYDg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Document the new "mba_MBps_event" file
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-9-tony.luck@intel.com>
References: <20241206163148.83828-9-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412375476.412.15475997368864513954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     faf6ef673787956ec4d33ac8bf56f8ea929abf37
Gitweb:        https://git.kernel.org/tip/faf6ef673787956ec4d33ac8bf56f8ea929abf37
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:48 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 12 Dec 2024 11:27:43 +01:00

x86/resctrl: Document the new "mba_MBps_event" file

Add a section to document a new read/write file that shows/sets the memory
bandwidth event used to control bandwidth used by each CTRL_MON group.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20241206163148.83828-9-tony.luck@intel.com
---
 Documentation/arch/x86/resctrl.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a824aff..6768fc1 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -384,6 +384,16 @@ When monitoring is enabled all MON groups will also contain:
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
 
+When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
+
+"mba_MBps_event":
+	Reading this file shows which memory bandwidth event is used
+	as input to the software feedback loop that keeps memory bandwidth
+	below the value specified in the schemata file. Writing the
+	name of one of the supported memory bandwidth events found in
+	/sys/fs/resctrl/info/L3_MON/mon_features changes the input
+	event.
+
 Resource allocation rules
 -------------------------
 

