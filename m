Return-Path: <linux-tip-commits+bounces-1510-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B2915109
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C4B285844
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48919ADAC;
	Mon, 24 Jun 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPBd4yP1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCihEfVt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900514264F;
	Mon, 24 Jun 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240649; cv=none; b=Ytija4hEZWTskUesGSrZ+u+g85Nqz4bgWV1jCaXGALgmQO0u4MpnzTm7/JZc4hjtqca9PP1qByif+1pLXjotUVWpnfj80ovOkdSD6yEl808UeEoC0vatv9IjNKvGHIbONtelwHiyweHPPj5ml4cRAOa/Ded27AL9Adi8D/C1vnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240649; c=relaxed/simple;
	bh=wLwPE9NF20ABJP/vg3ovc25jpB10XBFHKCE03qmzCHY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fo63ZGmoyJkktIzEqQYByxqpqn6dD6q7yTN62LGFJKf3bT6zklVBRzzRUGYV/zL7tndVWN9VRGztQgJFNTD6Cx+I5X1epfqKNb01LvFPBaBhIFJ9JiEiW2OaUBBkGOGMQVU74buq+vakPNNbvRWCr661zpIRaFuGsLdNHCRGH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPBd4yP1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fCihEfVt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 14:50:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719240646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63fzUkIeW2/4aPq7RNSGqwIwjByR2TNEJQK8AOHj1IQ=;
	b=LPBd4yP1DOa79vBmCbb20DmhxDsQ70CRDusuArOsrZwNEznxmXX0xw+DANEMUU1/QM3y4S
	PgdZF+X68yQkvgCM39CkN+54c4GbP/KuEOj6UHqeJ37xW9WGjOUdypYTTJX6znZIKt3tuJ
	/lcSJ6UlOvYIIMJ7tEJg0kNI3gcR/mTQ/1JuLXZ0iYA19r+NlDx3jsy9HZMq2kiMP/mVjH
	7gheVZF8yvybFsjP7Wg6WIWDL2SHfj7Dz4ZWgT0HEUfQbrc9HMymrKwBhXLvjAfyxzvx0l
	bvWiTyodcPWqi8Cv5Vrn3qUt4oI3xhjIeP4cM9iZW4l5dtPTPKu2OzxiXtnFHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719240646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63fzUkIeW2/4aPq7RNSGqwIwjByR2TNEJQK8AOHj1IQ=;
	b=fCihEfVtxKDxPpXBH9rX3HQTGkF58qwpvJX1RjvXLGFJrqtpMIFwqnal7sI9lQ3gzCc/WP
	k1+CqYnAth8SwVCw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Annotate racy debug variables
Cc: Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240611091813.1189860-1-leitao@debian.org>
References: <20240611091813.1189860-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924064527.10875.6526028546883683876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     5b5baba6222255d29626f63c41f101379ec5400b
Gitweb:        https://git.kernel.org/tip/5b5baba6222255d29626f63c41f101379ec5400b
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 11 Jun 2024 02:18:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 24 Jun 2024 16:46:43 +02:00

debugobjects: Annotate racy debug variables

KCSAN has identified a potential data race in debugobjects, where the
global variable debug_objects_maxchain is accessed for both reading and
writing simultaneously in separate and parallel data paths. This results in
the following splat printed by KCSAN:

  BUG: KCSAN: data-race in debug_check_no_obj_freed / debug_object_activate

  write to 0xffffffff847ccfc8 of 4 bytes by task 734 on cpu 41:
  debug_object_activate (lib/debugobjects.c:199 lib/debugobjects.c:564 lib/debugobjects.c:710)
  call_rcu (kernel/rcu/rcu.h:227 kernel/rcu/tree.c:2719 kernel/rcu/tree.c:2838)
  security_inode_free (security/security.c:1626)
  __destroy_inode (./include/linux/fsnotify.h:222 fs/inode.c:287)
  ...
  read to 0xffffffff847ccfc8 of 4 bytes by task 384 on cpu 31:
  debug_check_no_obj_freed (lib/debugobjects.c:1000 lib/debugobjects.c:1019)
  kfree (mm/slub.c:2081 mm/slub.c:4280 mm/slub.c:4390)
  percpu_ref_exit (lib/percpu-refcount.c:147)
  css_free_rwork_fn (kernel/cgroup/cgroup.c:5357)
  ...
  value changed: 0x00000070 -> 0x00000071

The data race is actually harmless as this is just used for debugfs
statistics, as all other debug variables.

Annotate all debug variables as racy explicitly, since these variables
are known to be racy and harmless.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240611091813.1189860-1-leitao@debian.org
---
 lib/debugobjects.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fb12a9b..7cea91e 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -78,16 +78,17 @@ static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
 
-static int			debug_objects_maxchain __read_mostly;
-static int __maybe_unused	debug_objects_maxchecked __read_mostly;
-static int			debug_objects_fixups __read_mostly;
-static int			debug_objects_warnings __read_mostly;
-static int			debug_objects_enabled __read_mostly
-				= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int			debug_objects_pool_size __read_mostly
-				= ODEBUG_POOL_SIZE;
-static int			debug_objects_pool_min_level __read_mostly
-				= ODEBUG_POOL_MIN_LEVEL;
+static int __data_racy			debug_objects_maxchain __read_mostly;
+static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
+static int __data_racy			debug_objects_fixups __read_mostly;
+static int __data_racy			debug_objects_warnings __read_mostly;
+static int __data_racy			debug_objects_enabled __read_mostly
+					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
+static int __data_racy			debug_objects_pool_size __read_mostly
+					= ODEBUG_POOL_SIZE;
+static int __data_racy			debug_objects_pool_min_level __read_mostly
+					= ODEBUG_POOL_MIN_LEVEL;
+
 static const struct debug_obj_descr *descr_test  __read_mostly;
 static struct kmem_cache	*obj_cache __ro_after_init;
 

