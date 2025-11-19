Return-Path: <linux-tip-commits+bounces-7405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 193C5C6DBDD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Nov 2025 10:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C9B2E29985
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Nov 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98C2FC010;
	Wed, 19 Nov 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSKSNOTj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="maEYd5FM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E093702F4;
	Wed, 19 Nov 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544812; cv=none; b=Fc+AP1rYCq+I8PTC3lYboKt42tLvuyjWG6TEukMZ3xxUw5PhVzYB91nPD/c3VpkGvoLB8o5IxW+eXFfv59IPIkv47TDiIl9kvIqw3GU+IjqgIYG/CodU6iBN+4Q9ZY4/rjksyxoWm96lf64sBx2BcT9EvwwnzmbT5LEGj3tP9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544812; c=relaxed/simple;
	bh=6PT20iCYuThGu+dkMi048h6j7hF72oUy9/Zl/QxRLP8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B0VWhzdCm92VA9rMryoCwu5B5jyCqw4O3jBt8K83x4cXfoi3areSUGyLp2yLncBNBHj6dfCdgRNvaMapHqdIHlEtp3Fe/OXrEjWz2D2qJ1uqVgSD5xOUvkFs03ZqiHnGxthdzrKQtRb4V54GrylC45t1JQUYO1apZ5b/xyTII0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSKSNOTj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=maEYd5FM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Nov 2025 09:33:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763544808;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZslTqd2ZYFU7VYpt+BcG+IqAyGP7L73o6gi9lgkdtBQ=;
	b=dSKSNOTjd1YurdIxXi0aOpCfhZMhusz4/jkyxCdWWVBTL5TtYGgZRQvqoa/AaOM8+fAiDR
	OC21QfaN8+cUY6tHLiKJ7W49vGJPHFcr/GiSNi9+60fONXgSbfm/0qooDhy3Ba6VVuoQ4C
	R8ZEjrEKHT3iQTWY78K7Ozt3QcgvH1kNgdRP81lPRPhH7EEqN5FhS5wdTJGAINceav3+S4
	GZpTAkXwPaG0WPdPhr8kYAALHDAcF43mn4ANk1BUImrbK4Qs+uYcty3/6OllQ1w0LT/FBF
	jDo8jV0qQm7cNZulegIWVw/ckw+X1LlxW9Gti5Rv/jgak5UE2XeMNqSKVYIrGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763544808;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZslTqd2ZYFU7VYpt+BcG+IqAyGP7L73o6gi9lgkdtBQ=;
	b=maEYd5FM5AugLLcs3G3dAPImhR6pkc2QQVkreWjoBb4uaLnX2rffnejW4zA6rtCi05E1Nr
	jX1iGOJB/sEIe7AA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Remove superfluous check
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Liang Kan <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251119091538.825307-1-jirislaby@kernel.org>
References: <20251119091538.825307-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176354479882.498.3642749619561141799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a24074ca8840cf28fa50c40e957fdc50f29971b3
Gitweb:        https://git.kernel.org/tip/a24074ca8840cf28fa50c40e957fdc50f29=
971b3
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Nov 2025 10:15:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Nov 2025 10:26:31 +01:00

perf/x86/intel/uncore: Remove superfluous check

The 'pmu' pointer cannot be NULL, as it is taken as a pointer to an array.
Remove the superfluous NULL check.

Found by Coverity: CID#1497507.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Liang Kan <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20251119091538.825307-1-jirislaby@kernel.org
---
 arch/x86/events/intel/uncore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d6c945c..e228e56 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1325,8 +1325,6 @@ static void uncore_pci_sub_driver_init(void)
 				continue;
=20
 			pmu =3D &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
-			if (!pmu)
-				continue;
=20
 			if (uncore_pci_get_dev_die_info(pci_sub_dev, &die))
 				continue;

