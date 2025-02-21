Return-Path: <linux-tip-commits+bounces-3564-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1230A3F62D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C693017CD1B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBCB20DD6D;
	Fri, 21 Feb 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C0PRUaT5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R93P2zsp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A820CCF5;
	Fri, 21 Feb 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145028; cv=none; b=AGZ2ZjZvWq/AKZEnx/u8uNThyxm2JrfEiWfpKKr+KneEiAW/HceSZStFumB9ckAM/09/n1P7rfKsGPEgoixcyhn4Z5wRmStyxFaVAb17Cc787U1V/4g9o1bU8A3220V5eajyODXGd916OJhP5YDkqE0qA+0ZDwJwW0jS4A/oouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145028; c=relaxed/simple;
	bh=MZUlVIod3FU94HpEe1uVUTzXo2D8/t3/tTYUn3PR6QY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bZFawAJO4B1eHxPebsJoajTQLOOKDLca5qX08zZVgEZBrmPRJIKIPV8bMrnuJ67DfTz+mI/leLL3SyL72iFXGBGWhQ//VnIY55dQIhtABIJwxPq5T/FjOqaA1UeTZG+baZUR6/I/vVKAqaCSph/02B2rWoY7wwFjc0CfNcjM+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C0PRUaT5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R93P2zsp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 13:37:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740145025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/boulHMpAVijzSn9K/0aFwXmfu+cZSzpY5K9TbNEk7w=;
	b=C0PRUaT5dxHUJG00uAQluIT8FEHCvS3BnOvlCHTQTx2KPO2+u0ofoCRrfCH5or++s45hC3
	srbXEAMmZLDtUANEH2WV3UP1OIsLmLc9EZX40w96JRR8ImIXX3jaOLyUsGP2xwE3ovoWgQ
	Hm9B4q7ApqKp+IR4zuvpALNPVbYaflL4hc8Jvey/ZBZYhBqsBtnZm3f1JWT0+iahH63yDR
	6jtL7Bnfa2TfL7vnxG63Mq7oixkZmF48Wo0HddCFOGvDhLm78+ysH/MxCEZbqAmFKcGJBn
	i/l8VjqTOFM9u41r5HEyjxWWe8S766Fou2MWDl/sLrVmW4ThmK7BHN6rhnDgpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740145025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/boulHMpAVijzSn9K/0aFwXmfu+cZSzpY5K9TbNEk7w=;
	b=R93P2zspvuysafmnIweGrVnCml7vMJvXtwEptVm/vMZZkkAKgNmK+aoSKDhoF/yXaRywxo
	EGsgbq/WdoKoFSCA==
From: "tip-bot2 for Brian Ochoa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] docs: arch/x86/sva: Fix two grammar errors under
 Background and FAQ
Cc: Brian Ochoa <brianeochoa@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219150920.445802-1-brianeochoa@gmail.com>
References: <20250219150920.445802-1-brianeochoa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014502450.10177.11575730496333668201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c9876cdb3ac4dcdf3c710ff02094165982e2a557
Gitweb:        https://git.kernel.org/tip/c9876cdb3ac4dcdf3c710ff02094165982e2a557
Author:        Brian Ochoa <brianeochoa@gmail.com>
AuthorDate:    Wed, 19 Feb 2025 10:09:20 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 14:24:51 +01:00

docs: arch/x86/sva: Fix two grammar errors under Background and FAQ

- Correct "in order" to "in order to"
- Append missing quantifier

Signed-off-by: Brian Ochoa <brianeochoa@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250219150920.445802-1-brianeochoa@gmail.com
---
 Documentation/arch/x86/sva.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/sva.rst b/Documentation/arch/x86/sva.rst
index 33cb050..6a75998 100644
--- a/Documentation/arch/x86/sva.rst
+++ b/Documentation/arch/x86/sva.rst
@@ -25,7 +25,7 @@ to cache translations for virtual addresses. The IOMMU driver uses the
 mmu_notifier() support to keep the device TLB cache and the CPU cache in
 sync. When an ATS lookup fails for a virtual address, the device should
 use the PRI in order to request the virtual address to be paged into the
-CPU page tables. The device must use ATS again in order the fetch the
+CPU page tables. The device must use ATS again in order to fetch the
 translation before use.
 
 Shared Hardware Workqueues
@@ -216,7 +216,7 @@ submitting work and processing completions.
 
 Single Root I/O Virtualization (SR-IOV) focuses on providing independent
 hardware interfaces for virtualizing hardware. Hence, it's required to be
-almost fully functional interface to software supporting the traditional
+an almost fully functional interface to software supporting the traditional
 BARs, space for interrupts via MSI-X, its own register layout.
 Virtual Functions (VFs) are assisted by the Physical Function (PF)
 driver.

