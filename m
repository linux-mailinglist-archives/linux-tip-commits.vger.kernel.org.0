Return-Path: <linux-tip-commits+bounces-7154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24416C28758
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CA6E4F13A3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5B30F556;
	Sat,  1 Nov 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7TywxiD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nv322zaj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720330EF65;
	Sat,  1 Nov 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026486; cv=none; b=m7+/tx67PXpHKS0B5z9QLbK6lT36Md0bhQA2g0+3dlyYe0Y9659vAp5676KxT23dgKYeBOUSmuAx96MTQu96+9LxJPxqLxn17JUvDFKVxCaQr2SXuPXkZqIGA9Ol1n3s18FN2VezNpFZpHFqn4IBjfR+2Qzxi6e9QyjDtvCqtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026486; c=relaxed/simple;
	bh=6JMvyprwviqPYPXAmTx0xtEH+Ms6o9HG9w0/CWCW8ZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZcVz2mQHGJQSRVzO5tpVjpL8r/u9wAq+1XP++zfmFFOr5W7YzmIuWOeZyBHE2ztwqmosKWjfmAN58y8BouaX3OABpRSA2XJ53Ip1Bu1dp3DzYBpgRwmc5US3bfH2BW2h0ZeTSapkXrxZw8gZD/34yqecR5WUEA0tIjQfN+pXoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A7TywxiD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nv322zaj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv34IAQBSln4A1i4MxdRz/R819dWCln5fZZcQdl9kNQ=;
	b=A7TywxiD5sYYaXoO9zLvqSuczoY4ZdVqNEe3umC99hEvPq4FGuWnVqjIKPUSwqZgjwa111
	MvgqcQiKxAqRMiPwJ+ktxazfNbLfjHcHTMUN6qJNiCH/4iHLm9mmd1gFOsi0nHhhlPtAjA
	y1wlDDuLtPVikHJ6h5frj9w7qOf3IjeSQQoi29wdijDsLbIc8V/SaVzZqJlZoVoJ4XJmO1
	8jzSJdVBQ2xlQXgV4O7xuqlRaW4SqynB93KWIIRHzQOWQv2n1ZmSW8r7DXM36CiIoXQ8L5
	k11S1iPZqYr+v+4p1QmfbplDsk8C+oG9DQ/6DDivyAYFMyxqMnXymjq60hLgcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv34IAQBSln4A1i4MxdRz/R819dWCln5fZZcQdl9kNQ=;
	b=nv322zajmcOEnKQgFn4qLmOxk5JgVXoFqyLmU/hoRVq7gugbMyhV/8G0GsyuvP4YIwFxQm
	5yWVqBNCHsNlyXBw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Add explicit includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-12-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-12-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648173.2601451.7017229150468265848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ce9850bdfcbd1022df3e99934a11d67966885694
Gitweb:        https://git.kernel.org/tip/ce9850bdfcbd1022df3e99934a11d679668=
85694
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:04 +01:00

vdso/gettimeofday: Add explicit includes

Various used symbols are only visible through transitive includes.
These transitive includes are about to go away.

Explicitly include the necessary headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-12-e0607bf4=
9dea@linutronix.de
---
 lib/vdso/gettimeofday.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 95df015..7b3fbae 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -3,8 +3,14 @@
  * Generic userspace implementations of gettimeofday() and similar.
  */
 #include <vdso/auxclock.h>
+#include <vdso/clocksource.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
+#include <vdso/ktime.h>
+#include <vdso/limits.h>
+#include <vdso/math64.h>
+#include <vdso/time32.h>
+#include <vdso/time64.h>
=20
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>

