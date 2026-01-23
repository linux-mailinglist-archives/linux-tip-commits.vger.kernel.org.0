Return-Path: <linux-tip-commits+bounces-8111-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH2sCFhXc2kDuwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8111-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Jan 2026 12:11:20 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D71774D5F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Jan 2026 12:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E6ED307E584
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Jan 2026 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F124A332EAD;
	Fri, 23 Jan 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gePLasUa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OPPbXe2X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083E22D78A;
	Fri, 23 Jan 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166401; cv=none; b=WqFTIeMIYLiOpFWUlhs6TL8iJqCfWN23l7f9gkdLniqtk9rWyHc2ZjtJxyI4qrBf1qw7cpV0n7AniFqzHXJ3MTjcILYfy6vsC0tj5zC4871ZQ87dF1KaU5JbFJIgcUrt1v3uutAIf0b62trp6jeDhiGSFPUspEVWFhU7dZSNsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166401; c=relaxed/simple;
	bh=tKd93ga5a7moVM0XH6sUTYmYj6Lo5N06bf5MXBX1XTY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dwzpL+MibFZQ7SrlpwaScDpeEq1DHfHPsOzCQYI7wPYHFkBbN5wSd0Jdj0f91JFtYJE19uRYQMHyN3WycubLBHVW5jP5OYFASOOksHxFhU6e+7JWb8fkezJ5rY7ewg6cvK0BMoy2u+Wji4nL+5/HQLl8J7OHbxqTg0zzl+AyLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gePLasUa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OPPbXe2X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Jan 2026 11:06:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769166399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYdWlWFd3IO2DkGMQjiFrCIxxS62GcFeAumGiL31uf0=;
	b=gePLasUa9NRnxYJbINk7S2SeJ96nu6ZyJdz1cPuRgcr1zOFUXcFeUfE6PArAd+/1LIAAME
	iebvU1LhYqcBA84iOsmhAA9FxlDiYCJdNSs7tkdem2MPp6N/WcJsjzreJWH875cToE/0kG
	v3y2Jqsx9SowGYTvA5LoIzDqoe8iCVAiN5VnrgwlXrDSHirlsNsAPzYDTfUonynwByNmYZ
	FEXxhGTY5gvbU2F9JjJk6c3K9lJZF1VI8dIevsZGktwvl6ShIXX3SARoenvc/dwKzpZtNX
	4Xx4UlvbIifAJ+gdlKClUZ6/DKZKWshw0lfrGf3/v1el3stjyrm4H9foPEJwPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769166399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYdWlWFd3IO2DkGMQjiFrCIxxS62GcFeAumGiL31uf0=;
	b=OPPbXe2XVPguZ16Q7y/ZQACzLjxc0KMmxbdDbMS9qSCzPFP4ylfKWZm3Hnu5I74uBiIrEA
	DatZ6JQSB15hoSDg==
From: "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Disable scheduler feature NEXT_BUDDY
Cc: Mel Gorman <mgorman@techsingularity.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <fyqsk63pkoxpeaclyqsm5nwtz3dyejplr7rg6p74xwemfzdzuu@7m7xhs5aqpqw>
References: <fyqsk63pkoxpeaclyqsm5nwtz3dyejplr7rg6p74xwemfzdzuu@7m7xhs5aqpqw>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176916639767.510.9429247977258489348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8111-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto,infradead.org:email,techsingularity.net:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6D71774D5F
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4f70f106bca1a56bd66d00830ac91680bd754974
Gitweb:        https://git.kernel.org/tip/4f70f106bca1a56bd66d00830ac91680bd7=
54974
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 20 Jan 2026 11:33:35=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 23 Jan 2026 11:53:19 +01:00

sched/fair: Disable scheduler feature NEXT_BUDDY

NEXT_BUDDY was disabled with the introduction of EEVDF and enabled again
after NEXT_BUDDY was rewritten for EEVDF by commit e837456fdca8 ("sched/fair:
Reimplement NEXT_BUDDY to align with EEVDF goals"). It was not expected
that this would be a universal win without a crystal ball instruction
but the reported regressions are a concern [1][2] even if gains were
also reported. Specifically;

o mysql with client/server running on different servers regresses
o specjbb reports lower peak metrics
o daytrader regresses

The mysql is realistic and a concern. It needs to be confirmed if
specjbb is simply shifting the point where peak performance is measured
but still a concern. daytrader is considered to be representative of a
real workload.

Access to test machines is currently problematic for verifying any fix to
this problem. Disable NEXT_BUDDY for now by default until the root causes
are addressed.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Link: https://lore.kernel.org/lkml/4b96909a-f1ac-49eb-b814-97b8adda6229@arm.c=
om [1]
Link: https://lore.kernel.org/lkml/ec3ea66f-3a0d-4b5a-ab36-ce778f159b5b@linux=
.ibm.com [2]
Link: https://patch.msgid.link/fyqsk63pkoxpeaclyqsm5nwtz3dyejplr7rg6p74xwemfz=
dzuu@7m7xhs5aqpqw
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 980d92b..136a658 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -29,7 +29,7 @@ SCHED_FEAT(PREEMPT_SHORT, true)
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.
  */
-SCHED_FEAT(NEXT_BUDDY, true)
+SCHED_FEAT(NEXT_BUDDY, false)
=20
 /*
  * Allow completely ignoring cfs_rq->next; which can be set from various

