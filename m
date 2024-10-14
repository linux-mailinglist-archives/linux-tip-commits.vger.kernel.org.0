Return-Path: <linux-tip-commits+bounces-2407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A899D564
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Oct 2024 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF2B1F24531
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Oct 2024 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671F38F64;
	Mon, 14 Oct 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PX/geZ6o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lV9OJCJq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65141AB507;
	Mon, 14 Oct 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926130; cv=none; b=qyL2AuxtpRm5YP5qGlvXQhlH2rj/aQcOw27/Keb5Vec/DRYeb1+qf+rx5zs66Hr9VW39AFYkPIhwap2I9PPGCKgkD8GEUklGHPRjaCQmRFardgUJ/bRNYKdmVYGGauIJawXyb9YjSvBokj6qFlXdcx6kFYk3NTH8oOxsUEn5rX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926130; c=relaxed/simple;
	bh=n5Kbeynb9dYQqAYNARe8OK4pIiXFkQVB7iVuUzmt4lA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dwOoIsvcT7Vjs1BH6lvG110C3+B821jVbmveKU5g3pmmzkt3mSwzgmXXaQHtLyv+qh1if5Mtt+z76+CSbJPW1/869ylzxVIwyS0waanpKcpE2t41c00l4zT6tQm2R1EkK/sA83IXvJrKU7oRMxDuFf4j3++GZYIfFVsxayFfBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PX/geZ6o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lV9OJCJq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Oct 2024 17:15:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728926126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjGR580tfrYCHIjnzfz5A20mun0pLBD6siz0jwVGOYw=;
	b=PX/geZ6oCLoM7/6+6BNJO0kXM35KUPHlBq791e2SCC+kzHezNQZ7WsiRVOuLiRw3E4uJ21
	iUq6SvppO6n+1gAZHYB3h2/TXB2UlbdnTFZi3oc6+TZidq1VF1lpOTIChPCNApDZGhdCe/
	uw9puIEHhG6twKDA0+tyztx9gOGDJ/99nSZaKYH3bQDtZDkRFMpBGNSqDxsBCmd79/0/F/
	ORRbfmX0b+mS6tPZyNuQZ0JJ6g/D1xgKPGroCAuPRoftvjHPnzBLfutUcqEqBha5fEACPv
	N7+KEr54ji45KyfMI2L5qQ1M5JGwGLKY6zuHAHrNkPctIRda6fCGvFFZJhUVqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728926126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjGR580tfrYCHIjnzfz5A20mun0pLBD6siz0jwVGOYw=;
	b=lV9OJCJqUe3Dd0aLtqZbgJMVfKsMcD35ZtasObDTsJtJPRb2Vhf5Nk1URp1iPIFZZAmSyL
	lZ4bYsFJQJuR4UBQ==
From: "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Slightly clean-up mbm_config_show()
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb2ebc809c8b6c6440d17b12ccf7c2d29aaafd488=2E17208?=
 =?utf-8?q?68538=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Cb2ebc809c8b6c6440d17b12ccf7c2d29aaafd488=2E172086?=
 =?utf-8?q?8538=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172892612576.1442.8509245466738133480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     29eaa79583671f1e1b468760d505ef837317ab15
Gitweb:        https://git.kernel.org/tip/29eaa79583671f1e1b468760d505ef837317ab15
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sat, 13 Jul 2024 13:02:32 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Oct 2024 18:58:24 +02:00

x86/resctrl: Slightly clean-up mbm_config_show()

'mon_info' is already zeroed in the list_for_each_entry() loop below.  There
is no need to explicitly initialize it here. It just wastes some space and
cycles.

Remove this un-needed code.

On a x86_64, with allmodconfig:

  Before:
  ======
     text	   data	    bss	    dec	    hex	filename
    74967	   5103	   1880	  81950	  1401e	arch/x86/kernel/cpu/resctrl/rdtgroup.o

  After:
  =====
     text	   data	    bss	    dec	    hex	filename
    74903	   5103	   1880	  81886	  13fde	arch/x86/kernel/cpu/resctrl/rdtgroup.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/b2ebc809c8b6c6440d17b12ccf7c2d29aaafd488.1720868538.git.christophe.jaillet@wanadoo.fr
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7163b7..d906a1c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1596,7 +1596,7 @@ static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info
 
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info = {0};
+	struct mon_config_info mon_info;
 	struct rdt_mon_domain *dom;
 	bool sep = false;
 

