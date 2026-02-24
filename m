Return-Path: <linux-tip-commits+bounces-8243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMXGFERYnWlzOgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:50:28 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FB18347A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8671B301E205
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BE3451BB;
	Tue, 24 Feb 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="waT7brD+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zK/OcENJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1D3009E2;
	Tue, 24 Feb 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771919248; cv=none; b=sb56f0fIDcH1k0Ld6CgIllFyoo6ZZihLjoGgmJI6itvBOAuOSpkIGSOpVc05lly7jeKmNhBRwr+NE5Mnf45bMSgPbEqrIk63K3o2QMGUIfuRI+xvPYfG3SfUnrmP9NHQVwpgkMCOw5gnC1d+MAeZF+UT9dtqDNJvSWN94Jzyhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771919248; c=relaxed/simple;
	bh=tUGK0U/gG9WNPxEw0mU03CF+ezPt+HpKxeas3DgmHqI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h75Mii6L5UbmqJTm3sX529j/kE9BiO9wWPNXVizCEW/mgIkygVxlvpia6BXQ5wUlD3s23smFYfxYcr0TNxVC79OpyFfPqsf/XqvAuRP3oKUZ4VWDBO1c6uHuQDbzjALGQk22exKr1AaD96j2jDMiXHtSfdytPusuZ88GqYKn+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=waT7brD+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zK/OcENJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:47:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771919246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/HRs5B4A5DyXQCrlo8ci5lX+lW38NzibBqXR2hEqUo=;
	b=waT7brD+89lVi/tzdN6xTcTsUMySYY0Rf9NXlYf058kJ5I/bUc3/XhN5Qucs3pw+QuDhZP
	0R+mhGXIhM47dLhz0a1MHZwDFuTXs11vdnqIF3E4ck6FeWcwYAS1YAWvV01T8hTE83AuYM
	hP4KCizjp5fn5P3ZKd1AqeiHRVGcIVyXa4n6IcFv6K38EgOU4yCxq01wOCAFh7Ocn0vKZo
	u1A5xIdkyOWK+uY3vZk9pG8N9zPy4vnnY8jN7RnJ9dJXTkrrPEpMtyovb8ay/W9FuxK8py
	V6cwn/3uLZtRaTUpCtACzB+ePYwYXfSQ09HzYDDP5ZYSBO+oHbnzcanu5rxznA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771919246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/HRs5B4A5DyXQCrlo8ci5lX+lW38NzibBqXR2hEqUo=;
	b=zK/OcENJ6q2AncMrLpBlZnus/kRNOSuC6oL8kUPmQR00WvT+Xe9eyt/yomGi391nNQUSSe
	IvJIba+/af9asODQ==
From: "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] jiffies: Remove unused __jiffy_arch_data
Cc: Petr Pavlu <petr.pavlu@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260217112638.1525094-1-petr.pavlu@suse.com>
References: <20260217112638.1525094-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191924495.1647592.3827410610932395786.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8243-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: B48FB18347A
X-Rspamd-Action: no action

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ecfa23b486b22844855844202424bc1966cebb33
Gitweb:        https://git.kernel.org/tip/ecfa23b486b22844855844202424bc1966c=
ebb33
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Tue, 17 Feb 2026 12:26:15 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:41:51 +01:00

jiffies: Remove unused __jiffy_arch_data

The __jiffy_arch_data definition was added in 2017 by commit 60b0a8c3d248
("frv: declare jiffies to be located in the .data section") for the needs
of the frv port. The frv support was removed in 2018 by commit fd8773f9f544
("arch: remove frv port") and no other architecture has required
__jiffy_arch_data. Therefore, remove this unused definition.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260217112638.1525094-1-petr.pavlu@suse.com
---
 include/linux/jiffies.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index fdef2c1..1a393d1 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -67,10 +67,6 @@ extern void register_refined_jiffies(long clock_tick_rate);
 /* USER_TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
 #define USER_TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
=20
-#ifndef __jiffy_arch_data
-#define __jiffy_arch_data
-#endif
-
 /*
  * The 64-bit value is not atomic on 32-bit systems - you MUST NOT read it
  * without sampling the sequence number in jiffies_lock.
@@ -83,7 +79,7 @@ extern void register_refined_jiffies(long clock_tick_rate);
  * See arch/ARCH/kernel/vmlinux.lds.S
  */
 extern u64 __cacheline_aligned_in_smp jiffies_64;
-extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data j=
iffies;
+extern unsigned long volatile __cacheline_aligned_in_smp jiffies;
=20
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);

