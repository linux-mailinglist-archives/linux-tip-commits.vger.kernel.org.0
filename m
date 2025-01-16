Return-Path: <linux-tip-commits+bounces-3276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D364A13A94
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 14:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A2F3A4CD0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C41E47A5;
	Thu, 16 Jan 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXES0yfW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IcrMC3CH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CD1F2391;
	Thu, 16 Jan 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033160; cv=none; b=Gc32HmOhll1gHyPjxdgz2FwO68vXv7FtVJl9hl02of4Q8BQJMZ7lfkdv7LL2mcZ2VnUebKesuVxz7GxTDVB42Y+1V8l8dBk/DkKO7fQgYVLHcSPR9Wqug2Pere2CxvJa3S1J5l57wbT4WU7oH7LaFfaFtGtuPFivwlV4xqmkcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033160; c=relaxed/simple;
	bh=wE8bL5TDB/+CNcWPXtMBe4LKpFAJKUwucbz2o3RBDL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rIvrCkQObvjmZDVCqldlVIvAAy5hOZ5MaOfTBXTnGoO31QdC35aA8Pju9NMS/B5OI+OthTs2QYDHxwtgwfTmeLjo2VrjkG6lqsEHkz8MI7Hc28IPusmAqaRehGeLpPTBHQwHU5QEkW1SwnQs/wUTkgSaKu70sQ6S/ErhVeCBE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXES0yfW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IcrMC3CH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 13:12:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737033156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb0NjYyjGpHfmsyrhEaEoI3+/+mRnYvL0RkIbjb3a9A=;
	b=aXES0yfWAnSHpZ+32TLr1dOwq9KlE2euJzbljM//3udrGTkUgdCVRZE7VihonV88Qxm0UA
	gGZ8HOVTJSlEjbVw8+oo7+Bpi1VhoKl4cj54NFCJVhAEsC29N5a9wmdiOaYWcweXZlG82O
	kIX5kvQ2la2pz65nh0s0gXXIOV4+6p4L3e3zafn4quLN6jQcjXXM52IxIZ54G6GnX0fQdW
	OZyEa1cPJ/rYl2i0ls7r2yrExbLTUtiGGXwOMIcafkweIy3O8Lvtn/anyaP+I21JwFmA1k
	5uTGRggkAE4Z6gIVHrd3LUW+h5qov+4M2M6EnK0RfMWazpN4pyYpgcRwl+eWIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737033156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb0NjYyjGpHfmsyrhEaEoI3+/+mRnYvL0RkIbjb3a9A=;
	b=IcrMC3CHz1kBdogN+DtT7BNMZaVY+wml6le/S3qBpTtr2Vq0k7l5k2fQdfmmnHnNcmcPZJ
	a03ZoXcxeEXaEbBA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Simplify top level detection on
 group setup
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250114231507.21672-5-frederic@kernel.org>
References: <20250114231507.21672-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173703315576.31546.11361231237779733210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dcf6230555dcd0b05e8d2dd5b128dcc4b6fc04ef
Gitweb:        https://git.kernel.org/tip/dcf6230555dcd0b05e8d2dd5b128dcc4b6fc04ef
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 15 Jan 2025 00:15:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 14:01:09 +01:00

timers/migration: Simplify top level detection on group setup

Having a single group on a given level is enough to know this is the
top level, because a root has to have at least two children, unless that
root is the only group and the children are actual CPUs.

Simplify the test in tmigr_setup_groups() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250114231507.21672-5-frederic@kernel.org

---
 kernel/time/timer_migration.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 8d57f76..6163376 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1624,9 +1624,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		 * be different from tmigr_hierarchy_levels, contains only a
 		 * single group.
 		 */
-		if (group->parent || i == tmigr_hierarchy_levels ||
-		    (list_empty(&tmigr_level_list[i]) &&
-		     list_is_singular(&tmigr_level_list[i - 1])))
+		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
 			break;
 
 	} while (i < tmigr_hierarchy_levels);

