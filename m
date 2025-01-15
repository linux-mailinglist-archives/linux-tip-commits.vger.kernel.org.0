Return-Path: <linux-tip-commits+bounces-3254-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D871EA12B30
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E20618857F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD619E7ED;
	Wed, 15 Jan 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CdYUBXGi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vBhh5nyG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60031D88A4;
	Wed, 15 Jan 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967266; cv=none; b=Rr8vJqym6gq8jFyOeDGSaOdIIaKY/AyHfyo2UlraMsWl6D8ej7DavmfeoyMlhldM3iHBiMYrTdtv+8GPMBDqPXio2bcZgPtI5RwXWEJSFDSEVe3V+blYl57AW851wT3HKdVI+iDwuxSibTesqoTWIzoOBMwlwd91+LOJS2+hsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967266; c=relaxed/simple;
	bh=GZKlbAfhkE6hypwcAenyxWq4WmA4H03Vv4l/xQ7Vs3w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VPypxmUUEVyxcyA/cUCbKLVe9PX/3cOsaRxijB/qQz+5hW/yCrlaabVRixaSHvDdp4QCUORpqHsdAwuIHQH4uJXqeEv5aurzggsQxUsLYbNEGRUOZXtjNO0fPB0AjqM9RRhF7cZHibcvhDqKYFjrtFvLWxKIhljncxlCiY4a/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CdYUBXGi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vBhh5nyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 18:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736967263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiZyPrSyojtA9FfyPq8kIe3q3LiSgviC0hpomFyK1qw=;
	b=CdYUBXGi1x/neJC48njsnOq89n5JrYE7lr5O8BH//pHGQUcD1wdu5xygy++B25ggg6b/Vz
	/MspZ0x0WfeAPy38r28cOEnmS4G5CpUULViPlBoKgAFmxdbKzaT87O+ThvSQ95LptmuX4A
	Y5fVaNnZMDPQzB5ICaq7CummNj5B2giE65AYvQbG8ipy8uAB/WTg2ypYbF/UNwmFX2wyGv
	V0TbUCPELc0jz4cPvAexD8ffVGW5pXWgsbdVS4zcDUhgPxOmVC8iCFAOsJ8erudtVYnqHF
	6O/XG1fo255xRtjlbJSF+FGANoVFIOzAENqZqKNr4N+qp/izD1bxyxfTvZ25AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736967263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiZyPrSyojtA9FfyPq8kIe3q3LiSgviC0hpomFyK1qw=;
	b=vBhh5nyGngrO0pyC3Zf6C0TnE3TPGhJWdnO5/qixieN8SPE5aOL4sNgBdTkpxTkAkDuvJZ
	EFX9GwBbFq16jjDg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timer/migration: Fix kernel-doc warnings for union
 tmigr_state
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250111063156.910903-1-rdunlap@infradead.org>
References: <20250111063156.910903-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696726254.31546.17388862423188166493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4477b0601471ba4fc67501b62b78aebd327fefd7
Gitweb:        https://git.kernel.org/tip/4477b0601471ba4fc67501b62b78aebd327fefd7
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 10 Jan 2025 22:31:56 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 19:49:14 +01:00

timer/migration: Fix kernel-doc warnings for union tmigr_state

Use the correct kernel-doc notation for nested structs/unions to
eliminate warnings:

timer_migration.h:119: warning: Incorrect use of kernel-doc format:          * struct - split state of tmigr_group
timer_migration.h:134: warning: Function parameter or struct member 'active' not described in 'tmigr_state'
timer_migration.h:134: warning: Function parameter or struct member 'migrator' not described in 'tmigr_state'
timer_migration.h:134: warning: Function parameter or struct member 'seq' not described in 'tmigr_state'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250111063156.910903-1-rdunlap@infradead.org

---
 kernel/time/timer_migration.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 154accc..ae19f70 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -110,22 +110,19 @@ struct tmigr_cpu {
  * union tmigr_state - state of tmigr_group
  * @state:	Combined version of the state - only used for atomic
  *		read/cmpxchg function
- * @struct:	Split version of the state - only use the struct members to
+ * &anon struct: Split version of the state - only use the struct members to
  *		update information to stay independent of endianness
+ * @active:	Contains each mask bit of the active children
+ * @migrator:	Contains mask of the child which is migrator
+ * @seq:	Sequence counter needs to be increased when an update
+ *		to the tmigr_state is done. It prevents a race when
+ *		updates in the child groups are propagated in changed
+ *		order. Detailed information about the scenario is
+ *		given in the documentation at the begin of
+ *		timer_migration.c.
  */
 union tmigr_state {
 	u32 state;
-	/**
-	 * struct - split state of tmigr_group
-	 * @active:	Contains each mask bit of the active children
-	 * @migrator:	Contains mask of the child which is migrator
-	 * @seq:	Sequence counter needs to be increased when an update
-	 *		to the tmigr_state is done. It prevents a race when
-	 *		updates in the child groups are propagated in changed
-	 *		order. Detailed information about the scenario is
-	 *		given in the documentation at the begin of
-	 *		timer_migration.c.
-	 */
 	struct {
 		u8	active;
 		u8	migrator;

