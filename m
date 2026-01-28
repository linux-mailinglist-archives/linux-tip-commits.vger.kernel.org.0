Return-Path: <linux-tip-commits+bounces-8137-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB0qBFmSemlC8AEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8137-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 23:48:57 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF56A9BFD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 23:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B40A300A4D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA433EBF04;
	Wed, 28 Jan 2026 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvCybvKn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82724CEEA
	for <linux-tip-commits@vger.kernel.org>; Wed, 28 Jan 2026 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640533; cv=none; b=gifu4z7hpE5ZKvvBAa3kdo45RDneGXR6Giv49AKrcksArh/czRladLVe/x5rkWkhHuIXqNSTO2oo0FowNMiKavJNu/V8FU1APt9cE5TD/fxqowIBvrOkR0UT0fuf+Q9I8HWZWtqFFV3Wg0fOaBnkYsLiJ2ye9S7KZNtzxWqR3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640533; c=relaxed/simple;
	bh=9lde7Ivrwg7Fj7JNiDH/ELhD3pjs8jGXKfeRyrJfImk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drYxcq7q8xD5G94CnRxIXbUhoOsGgZtMFAvvOnolSrbcYAXDcYBHGyXDCi5knUC1uhyHmA1yV0EkenvrNrN7NJlZ738AJh2FR5tn+tWk9+lCnIA7Sc+gyq2/9+lDafRfIi0pVM2PSgAyqLuO8SW6HcLn+gspS5cQyP5ZR8AcoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvCybvKn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769640531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSit5hT7x15zRkxpWSCotyN0t1cBlE4U/MDOqNefmRs=;
	b=CvCybvKnC2D2joAFMYM+fpi0NPVlhhHBASA4QvBbbCSRQ6jSAn6FC+L2jnqh1RhpmFsHMq
	9com4hF4qb6w9XeC/Ru07TtVUA0AvVjk3A8MjvBgQjkiSMLCsEO65xisysjLvARWEsQT+r
	daW1DM0GkbBeU7wE633Uhdz0Xz6wKow=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-Glz2ISrdM32urSl3tdKprQ-1; Wed,
 28 Jan 2026 17:48:49 -0500
X-MC-Unique: Glz2ISrdM32urSl3tdKprQ-1
X-Mimecast-MFC-AGG-ID: Glz2ISrdM32urSl3tdKprQ_1769640528
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4235D18005AD;
	Wed, 28 Jan 2026 22:48:48 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.89.161])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8D2530001A2;
	Wed, 28 Jan 2026 22:48:45 +0000 (UTC)
Date: Wed, 28 Jan 2026 17:48:43 -0500
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Fix build for modules using
 set_tsk_need_resched()
Message-ID: <20260128224843.GA185446@pauld.westford.csb>
References: <20260112140413.362202-1-gmonaco@redhat.com>
 <176851345987.510.6507406232761244840.tip-bot2@tip-bot2>
 <20260115233803.GD1039042@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115233803.GD1039042@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pauld@redhat.com,linux-tip-commits@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8137-lists,linux-tip-commits=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 4CF56A9BFD
X-Rspamd-Action: no action

Hi Peter and Gabriele,

On Thu, Jan 15, 2026 at 06:38:03PM -0500 Phil Auld wrote:
> On Thu, Jan 15, 2026 at 09:44:19PM -0000 tip-bot2 for Gabriele Monaco wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     8d737320166bd145af70a3133a9964b00ca81cba
> > Gitweb:        https://git.kernel.org/tip/8d737320166bd145af70a3133a9964b00ca81cba
> > Author:        Gabriele Monaco <gmonaco@redhat.com>
> > AuthorDate:    Mon, 12 Jan 2026 15:04:13 +01:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 15 Jan 2026 22:41:26 +01:00
> >
> 
> Thank you for both of these, Peter!

Well, I think this one and the related one need to lose the _GPL because
they are called from things, like wake_up_process(), which are exported
without that restriction. This essentially adds _GPL to that and
anything else that ends up in resched_curr().

I prefer to add new symbols _GPL too but this case seems different.

Thoughts?

I can spin up a patch against tip:sched/core if you want it.


Cheers,
Phil

> 
> > sched: Fix build for modules using set_tsk_need_resched()
> > 
> > Commit adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
> > added a tracepoint to the need_resched action that can be triggered also
> > by set_tsk_need_resched.
> > This function was previously accessible from out-of-tree modules but
> > it's no longer available because the __trace_set_need_resched() symbol
> > is not exported (together with the tracepoint itself, which was exported
> > in a separate patch) and building such modules fails.
> > 
> > Export __trace_set_need_resched to modules to fix those build issues.
> > 
> > Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > Link: https://patch.msgid.link/20260112140413.362202-1-gmonaco@redhat.com
> > ---
> >  kernel/sched/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index b033f97..3cca012 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1139,6 +1139,7 @@ void __trace_set_need_resched(struct task_struct *curr, int tif)
> >  {
> >  	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
> >  }
> > +EXPORT_SYMBOL_GPL(__trace_set_need_resched);
> >  
> >  void resched_curr(struct rq *rq)
> >  {
> > 
> 
> -- 
> 

-- 


