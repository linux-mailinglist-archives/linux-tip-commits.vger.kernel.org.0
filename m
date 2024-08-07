Return-Path: <linux-tip-commits+bounces-1963-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849EF94A646
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 12:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65371C22345
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE661DF688;
	Wed,  7 Aug 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbuTffB6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5COCpRct"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150C1E2887;
	Wed,  7 Aug 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027906; cv=none; b=mGwjsyU+f+jteY8urGF2TYM59FHSVEY1tt9opMPam0WCHRlrs+gf5Mm1Qf7zDAcqbvwbxX8EQMbkwHTG8Y0/5MJI4N+edKF42luV6xHYM3VpvRwfDeWYPrzX2A5z2NyRiXMYszpvg0aoXlkuaulvysZr5KZfeUgLZRqJp0HNF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027906; c=relaxed/simple;
	bh=wxSY4e5mZm5nbRFZvFRKuC1x4UFJ6if3X+AEvE9+fLc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FtjPqNriBopR90UwTxsSzsmvhoSeuCRYoT5C27siSBjlP7qHg8tm1+10tGtcIEeobAa6lV/A+FZKww294LCU4fdsPA8+oZflAuJEpb9yrAut36idaTM//WEYwptdrZAKH4FsRqjGpief9OtlIAwdKod7We3UphwtNlmmNuyHtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbuTffB6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5COCpRct; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efs4+JuaTE5KXKH1CpGKW4KmSbGLCyE6Ec74HyvNptg=;
	b=nbuTffB6xCJBiASduvE9ZLsCyURrmNsEX4FJMAe/kTZIXOFW1aUwLFgFn3DOxN8oLHijx1
	hO/gtBRav4WvLx0BUe7qV5k4HLZdIoBHLT8l0sAfS6QtvTky+uNR7BwhHNn4ljDjsrgV81
	P0Im6EK+3fZhs67wNyub5u/cOp+U2MbE9gysYT8ObAo6bx7ZtrGm4OmVPOHpDHAss2V+9j
	6tfHBU8bmdkyvujQh34mB2WDH42Law+zabXBfJQaGoWOwxB5LtaC/sbSvCqI2JURWhRecq
	FryDD2c6ltT8sf7TpDMA9Ljw/KAKJD4HBPYYcSJnQE2TEmr7BsGlzuEppUM6DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efs4+JuaTE5KXKH1CpGKW4KmSbGLCyE6Ec74HyvNptg=;
	b=5COCpRct2DGX7o4n/Y6N2KX9r6ks1p4mc56ICaDnP5/SyuJxcyPJXw5qZBKQAwH4avKzlu
	bohhXdVU8zOgovCA==
From: "tip-bot2 for Zhenyu Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Use D0:F0 as a default device
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731141353.759643-5-kan.liang@linux.intel.com>
References: <20240731141353.759643-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302789705.2215.10644876568703251327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     aaad0e2aa50723969f96b690f72e2f4aefa433f2
Gitweb:        https://git.kernel.org/tip/aaad0e2aa50723969f96b690f72e2f4aefa433f2
Author:        Zhenyu Wang <zhenyuw@linux.intel.com>
AuthorDate:    Wed, 31 Jul 2024 07:13:53 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:46 +02:00

perf/x86/intel/uncore: Use D0:F0 as a default device

Some uncore PMON registers are located in the MMIO space of the Host
Bridge and DRAM Controller device, which is located at D0:F0 for
Tiger Lake and later client generation.

Use D0:F0 as a default device. So it doesn't need to keep adding the
complete Device ID list for each generation anymore.

Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240731141353.759643-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index f7402bd..3934e1e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1504,6 +1504,10 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 		ids++;
 	}
 
+	/* Just try to grab 00:00.0 device */
+	if (!mc_dev)
+		mc_dev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+
 	return mc_dev;
 }
 

