Return-Path: <linux-tip-commits+bounces-8029-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32AAD29473
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 00:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 362853008751
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 23:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32632692F;
	Thu, 15 Jan 2026 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTaOEwvt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E63176E1
	for <linux-tip-commits@vger.kernel.org>; Thu, 15 Jan 2026 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520295; cv=none; b=hXfWA5zWk0rgLYJLJwXHUyuBdcJKpQGkE6D+9cDt+lCoeU47V2e39PRMq6mWJGhd+sLBZeQy6j9ct+pVXwldZewDIu4k79xlOkcq2IQUaFrjWJezfnEgs7SSl83kNu74a6gapuJEU/qxNZLSqb4d5gN8sCjXxXNmJGGCt6hGva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520295; c=relaxed/simple;
	bh=5R+H7RlBh/BOyc2NDitFJ3MUVbIZZQrMQM5gHfKy/ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr7gBu5FLV9vOKUVh1zzpM23WmaADhP8cJeeujybqM4ge+EswhlIbkuXkb0pPV7wmIf/Kp/OS2GVl9aslCOH2Ow7wVMkRvoXafih3CvNH8apY5jbEqt0UlGyRAVbn8YYC8c++UJcRdwBd580+QyA4x1GVYEvFfoeDetjGoejfj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTaOEwvt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768520292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35CEsfjRQdQ+OwU9+Cca4TWBbP+9Hnd4LKT+qjgrJ+M=;
	b=PTaOEwvtd7BvlAZoa83iGEY12nABRWd6w9W5OYA8OuM8YM5WEEYaW2PXjz/Mh9cCKa1bu4
	/oGy0aMCF7DxQmyhntsAqBs0Rg9qTypx2ECLIxSqtFlXh1QwNYDbp2mFuxBLi5wCxtT1If
	w9VjgRYfz/0S8GEib+rPmDrN1A1voC8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-PqT-3SynOZSXf7O1u9B-Iw-1; Thu,
 15 Jan 2026 18:38:09 -0500
X-MC-Unique: PqT-3SynOZSXf7O1u9B-Iw-1
X-Mimecast-MFC-AGG-ID: PqT-3SynOZSXf7O1u9B-Iw_1768520288
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FFDE19560A1;
	Thu, 15 Jan 2026 23:38:08 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C5BD30002D6;
	Thu, 15 Jan 2026 23:38:05 +0000 (UTC)
Date: Thu, 15 Jan 2026 18:38:03 -0500
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Fix build for modules using
 set_tsk_need_resched()
Message-ID: <20260115233803.GD1039042@pauld.westford.csb>
References: <20260112140413.362202-1-gmonaco@redhat.com>
 <176851345987.510.6507406232761244840.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176851345987.510.6507406232761244840.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 15, 2026 at 09:44:19PM -0000 tip-bot2 for Gabriele Monaco wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     8d737320166bd145af70a3133a9964b00ca81cba
> Gitweb:        https://git.kernel.org/tip/8d737320166bd145af70a3133a9964b00ca81cba
> Author:        Gabriele Monaco <gmonaco@redhat.com>
> AuthorDate:    Mon, 12 Jan 2026 15:04:13 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 15 Jan 2026 22:41:26 +01:00
>

Thank you for both of these, Peter!


Cheers,
Phil



> sched: Fix build for modules using set_tsk_need_resched()
> 
> Commit adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
> added a tracepoint to the need_resched action that can be triggered also
> by set_tsk_need_resched.
> This function was previously accessible from out-of-tree modules but
> it's no longer available because the __trace_set_need_resched() symbol
> is not exported (together with the tracepoint itself, which was exported
> in a separate patch) and building such modules fails.
> 
> Export __trace_set_need_resched to modules to fix those build issues.
> 
> Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Link: https://patch.msgid.link/20260112140413.362202-1-gmonaco@redhat.com
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b033f97..3cca012 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1139,6 +1139,7 @@ void __trace_set_need_resched(struct task_struct *curr, int tif)
>  {
>  	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
>  }
> +EXPORT_SYMBOL_GPL(__trace_set_need_resched);
>  
>  void resched_curr(struct rq *rq)
>  {
> 

-- 


