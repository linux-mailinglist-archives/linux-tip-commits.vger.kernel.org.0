Return-Path: <linux-tip-commits+bounces-2225-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B5972089
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A5A285B8F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD3187357;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QA41pkd9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6HVGc49"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E317E010;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902869; cv=none; b=RSfynUuzYJ43zTSZGvvbIIqj2tf7+G2eRJOiuKjds0sBv9eVdomNwlW1bwzlZmU1p7QqcBQ9s3Pcya6T8dls5BPQIvgNWxIwp6FpT0wXG+Zp14XrfYAUkKmxx/kkirR9nAFAA0+dGoLm3H7r64lWIAytr3Gp1ggd/Skynn5zInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902869; c=relaxed/simple;
	bh=Nr/NkNY8jb8CJMOIDL2IzksTk4bvSeBIj/Mt0EsIXG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=utE4myKK2uY2Qcd6dqv8jxYnA7kKWLRAiZiDorvYMfo51sS0LixeePVOnK3dzIf+LXmbtWqzwGt/DBjP5Z5xDLsSB6QOK71GrgmLZAi+KTJHr7B6lG7mb42iqkCcl+MnZU23InagyCFHMs5ab4eHSRje/I2ECI1PYEn5wccKFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QA41pkd9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6HVGc49; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDDk9xu2/8rnZpvVoe9ng3bR57wdRHcTEVBotY15OBo=;
	b=QA41pkd9PSg/OCen3VeRRhBIzUaCGL1xuoMaEumY7fCgS0hRUHCKlbFixUKm2O3LQb7col
	C4DhEAF6fV7UIzOhQArh00ziFE430LOC0elaGJTYgFKGbJWZRuIkodn3gujzBEsq2AC/Aj
	FkS3HygcZNWzQj94AzI2iCj0RIpn9lazCxYCFhEC1MmV53jrgxHgFeVISVgru9lRUnyEIx
	tkglGKsb3C6Qv74ErfEeFis2yhfrRwhP+OdCrxfO+noz5oDONhnwlw1EtNMx8ltd+Qug2K
	r5n2acYW2JaWYISTGe4lde/EwiLYG7joXmPEL9PSymFh+wsvZ/96WToIYY2GnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDDk9xu2/8rnZpvVoe9ng3bR57wdRHcTEVBotY15OBo=;
	b=J6HVGc49TMSk4KfBiHPDq1ZBunPymHjjPVP75ij02rIgYhiK7Ejjls1JWtbMRc0TqQvVNH
	6X8ZiEjWVlFakdDw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Relocate nbcon_atomic_emit_one()
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-8-john.ogness@linutronix.de>
References: <20240904120536.115780-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286519.2215.13261229710657630380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     9b79a3d0d64abae92457cb830baa6c6a717778b0
Gitweb:        https://git.kernel.org/tip/9b79a3d0d64abae92457cb830baa6c6a717778b0
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:26 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: nbcon: Relocate nbcon_atomic_emit_one()

Move nbcon_atomic_emit_one() so that it can be used by
nbcon_kthread_func() in a follow-up commit.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-8-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 78 +++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 388322c..57a0e9b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1042,6 +1042,45 @@ update_con:
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/*
+ * nbcon_atomic_emit_one - Print one record for an nbcon console using the
+ *				write_atomic() callback
+ * @wctxt:	An initialized write context struct to use for this context
+ *
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context cannot be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is done, cannot be
+ *		done, or will be handled by the owning context.
+ *
+ * This is an internal helper to handle the locking of the console before
+ * calling nbcon_emit_next_record().
+ */
+static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	/*
+	 * nbcon_emit_next_record() returns false when the console was
+	 * handed over or taken over. In both cases the context is no
+	 * longer valid.
+	 *
+	 * The higher priority printing context takes over responsibility
+	 * to print the pending records.
+	 */
+	if (!nbcon_emit_next_record(wctxt, true))
+		return false;
+
+	nbcon_context_release(ctxt);
+
+	return ctxt->backlog;
+}
+
 /**
  * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
  * @con:	Console to operate on
@@ -1319,45 +1358,6 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	return NBCON_PRIO_NORMAL;
 }
 
-/*
- * nbcon_atomic_emit_one - Print one record for an nbcon console using the
- *				write_atomic() callback
- * @wctxt:	An initialized write context struct to use for this context
- *
- * Return:	True, when a record has been printed and there are still
- *		pending records. The caller might want to continue flushing.
- *
- *		False, when there is no pending record, or when the console
- *		context cannot be acquired, or the ownership has been lost.
- *		The caller should give up. Either the job is done, cannot be
- *		done, or will be handled by the owning context.
- *
- * This is an internal helper to handle the locking of the console before
- * calling nbcon_emit_next_record().
- */
-static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
-{
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
-
-	if (!nbcon_context_try_acquire(ctxt))
-		return false;
-
-	/*
-	 * nbcon_emit_next_record() returns false when the console was
-	 * handed over or taken over. In both cases the context is no
-	 * longer valid.
-	 *
-	 * The higher priority printing context takes over responsibility
-	 * to print the pending records.
-	 */
-	if (!nbcon_emit_next_record(wctxt, true))
-		return false;
-
-	nbcon_context_release(ctxt);
-
-	return ctxt->backlog;
-}
-
 /**
  * nbcon_legacy_emit_next_record - Print one record for an nbcon console
  *					in legacy contexts

