Return-Path: <linux-tip-commits+bounces-3584-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F64A3FA75
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 17:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645BE1784D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3D215791;
	Fri, 21 Feb 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dEPLcBLs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfYMqX5n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C501F152C;
	Fri, 21 Feb 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153646; cv=none; b=lBxT4xJOalhQuXeLXaQ0EmeXQYeYwWkGOtn5sG0ANbgM5JBKpgJoE+55twb5uipovSSUXNR7sCQzId4TZfjUXGlLpq1POKXX1B4cAhO938vcmLnMK98nwvzLo6KYBqMgDO+SGlVHFdQIb8N5IxS4VA8ptHCcSc4RQ1zSu69mbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153646; c=relaxed/simple;
	bh=EhZQb+vWE2tTej5gdlqic9Fpf4Hd1jQ4SP1Ge1vvzjE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SDkJees2VPzuhu2hFYA/snYIfqL6arqCAc2O+xCPNu/+8hAZeuYX5Vw25CoKSH+8R/dx6oa7ZNxlkhpBRmqM/8FjC2wIK06pHK5rUnzWYsELsbGtkghJT8JgRBLRo9JBN0g3suWIy5G4rBFE4Z34a98ZtD89Ja3S4rJ0xOhsXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dEPLcBLs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfYMqX5n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 16:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740153642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk5pm5W5VMcoK87b30uuNR1ImzRkoLK+4F0SgG2l6Uw=;
	b=dEPLcBLsRccZMytsNDZDLrKgMoU0Hf7BhsSCU66Ea7QnDKWAxBRZtdjRS7ywJc3ApUFO2m
	ooIv/rtfPds5yZLg66ndJjHfQzsVdRkKzg3ZJbHl5wdDssxrR2lSVolocrFj5aCTNYnx2D
	p5E3TUEf+nT7huMqfnoxhB8W7LUCXkuizN2fgQpARu2b7BsiNkKG+PmZL7Qcgaiv0bhqo3
	q4VqtiWSbdr1rlyGNqabFpm0C5D1K3ZOufj2mliPx7bt3IcKuNKLGXZczlXZ7JltzVzFZO
	/Y8RvtUhsId8rjC+CnbQD64A5768urkOvCuaQIw2LmIKRvwZdswqbvJpYwNdaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740153642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk5pm5W5VMcoK87b30uuNR1ImzRkoLK+4F0SgG2l6Uw=;
	b=CfYMqX5nErdCWpDosRaIUTiJU9ILApdt//QJV4TSR4WcRO0feqYrtKXAAqdP8w1eItw4YV
	FfVsogBkNfcmYIDw==
From: "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/olpc-xo1-sci: Don't include
 <linux/pm_wakeup.h> directly
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250210113453.51825-2-wsa+renesas@sang-engineering.com>
References: <20250210113453.51825-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015364147.10177.12402894860780702277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     000894d8fc0d787b52a46339f297e20c024a6ca5
Gitweb:        https://git.kernel.org/tip/000894d8fc0d787b52a46339f297e20c024a6ca5
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Mon, 10 Feb 2025 12:34:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:45:00 +01:00

x86/platform/olpc-xo1-sci: Don't include <linux/pm_wakeup.h> directly

The header clearly states that it does not want to be included directly,
only via <linux/(platform_)?device.h>. Which is already present, so
delete the superfluous include.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250210113453.51825-2-wsa+renesas@sang-engineering.com
---
 arch/x86/platform/olpc/olpc-xo1-sci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index ccb23c7..63066e7 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
-#include <linux/pm_wakeup.h>
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>

