Return-Path: <linux-tip-commits+bounces-2526-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6099AB914
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA0EB2182A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB881CCEEF;
	Tue, 22 Oct 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="inIlv1fk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8Vrc3me"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2131CC8AA;
	Tue, 22 Oct 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634035; cv=none; b=u3ReJpE2GlzTS8x7LuuIMzzuy7DBKjMPpOzLevF5SvaFCItJs1IwURXS8EccjmK8I5JcfNfCgcUSPvWIzVm2blf3bNZsFf9vmV0UCruoNXngX/hZTQmrionGC20zFB/OXrETNUJYjwWrYHnGx2X4tk4g2+2SA/26RmRODZ+4YM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634035; c=relaxed/simple;
	bh=wdbTrOCrdW15oT7P+XZHDPIKlhGqVPoklagbUzNOsb8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fcvBgYNaiw6rHMYFbhiJqL8uhVVLvb0/7ftp/rKT+wQcdIFqxMSEDdxZdoS1l3UPOYRZ1BHaRQfoEwtCNyg9nvNIJmcUW6L/SCKNDIS3TbKr+ovRpT4WBhMynsx229Yd9FfkWGS1Xt9U2dB4Jj83r8ZAXPeGwC/Ee+J+YbqmJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=inIlv1fk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8Vrc3me; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 21:53:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729634031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sERpPQ8T93AXBfLvUpj5tpjwYiao9FajSfDwAelS8Mk=;
	b=inIlv1fk+04srBECg4crot5ZS9kHDrVtrxUWTH1kBRn2Xq9PObPk/dzNnRE5PFX7lxtVxW
	ioXbtssxlCkXgFs5B5SnZ+bhbdNHRjexnbv1ORA77BQ/wBgj7VSbHGAykHUGXhD1qYwB4e
	R5JmoxIi1pK821xLJeGXgxxLBj0PfZP/eust9/AzpXsXmAVboP62Y1xicCMThIHso0/+WL
	ioxfhNXnJycfTkC5U+XIxcANu8/HNE3hGo3xCXzbdx8Rqrr6Fsym6tlHX7OgTIU/aLLX8L
	pv7IL86l0AACQe7tA/29cpCcu7nDTs0Vrx6amSqRDAF9JcRI0YCLBiAqhGD2rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729634031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sERpPQ8T93AXBfLvUpj5tpjwYiao9FajSfDwAelS8Mk=;
	b=s8Vrc3meiYDeH3WfA+KrNPbd5Px5DcBb9goc6kLTp1EJfNKserSilBvOMH79PMcazSDgOk
	qNjIATUr0iqyYFAQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Enable PROVE_RAW_LOCK_NESTING with
 PROVE_LOCKING.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241009161041.1018375-2-bigeasy@linutronix.de>
References: <20241009161041.1018375-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172963403080.1442.10119121567439415054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     560af5dc839eef08a273908f390cfefefb82aa04
Gitweb:        https://git.kernel.org/tip/560af5dc839eef08a273908f390cfefefb82aa04
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 17:45:03 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 17 Oct 2024 21:21:16 -07:00

lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.

With the printk issues solved, the last known splat created by
PROVE_RAW_LOCK_NESTING is gone.

Enable PROVE_RAW_LOCK_NESTING by default as part of PROVE_LOCKING. Keep
the defines around in case something serious pops up and it needs to be
disabled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241009161041.1018375-2-bigeasy@linutronix.de
---
 lib/Kconfig.debug | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f64..5b67816 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1409,22 +1409,14 @@ config PROVE_LOCKING
 	 For more details, see Documentation/locking/lockdep-design.rst.
 
 config PROVE_RAW_LOCK_NESTING
-	bool "Enable raw_spinlock - spinlock nesting checks"
+	bool
 	depends on PROVE_LOCKING
-	default n
+	default y
 	help
 	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
 	 that the lock nesting rules for PREEMPT_RT enabled kernels are
 	 not violated.
 
-	 NOTE: There are known nesting problems. So if you enable this
-	 option expect lockdep splats until these problems have been fully
-	 addressed which is work in progress. This config switch allows to
-	 identify and analyze these problems. It will be removed and the
-	 check permanently enabled once the main issues have been fixed.
-
-	 If unsure, select N.
-
 config LOCK_STAT
 	bool "Lock usage statistics"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT

