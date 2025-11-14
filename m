Return-Path: <linux-tip-commits+bounces-7344-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6AC5D474
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03FB135D502
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770D9313E25;
	Fri, 14 Nov 2025 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czmPuOYE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CF313533
	for <linux-tip-commits@vger.kernel.org>; Fri, 14 Nov 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125684; cv=none; b=EQ9UPPM6vdEsUkivGH9WtPCp1rm3FwoLF6U7w+8WSUKU+2fj50oaXGS9sGYOzRWCEzndvaEgus5gyPytUaaMKTg9J7VSptNME73O5jP14O5VU2h8waF+w+AIGWHhkQVUw5W634OyzHgeo2/LQ5sWwghb5ax++Mnx4tIf3Jgqvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125684; c=relaxed/simple;
	bh=qF4T288kvBReLC5nH+HFRZYBwT226hSd99qcU21mFCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFeX1p4X1kyLQ7q0LorDbxf7cd3xocs2cefRJoWE37DisQ/hBqIWtD4vaHBgKJIbgodhpDDtqOiz1czEcMRimMBba9s6yL0lfQ+sg3jIQn30TANKqYUhqV82FwHMG3R5ZJI1TVjaEqborgFs0vPpylhc1u+DkM+UfJtaoUM8/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czmPuOYE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763125682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Rtp6BfBlRXPrvmS9si51K9hgwJ2l6G0nuPvzhdvjJc=;
	b=czmPuOYE2g4NI+viCYKNL148QFS2ZKHyWGF7t7JaBGn7S4D3UsO29+HYFlpEkz4oI7IdvR
	I+AN7G18PJ8VpmdViAnw+Tv+nc7GJiVIlwsCfdPXKhNixnrUxK6c8QstXh16LekGE9F0Vs
	f5RUiRhDKcpJQjcYO42R11ObRDS30xI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-FdngH6FcPZiMJf2bU6V7xg-1; Fri,
 14 Nov 2025 08:07:58 -0500
X-MC-Unique: FdngH6FcPZiMJf2bU6V7xg-1
X-Mimecast-MFC-AGG-ID: FdngH6FcPZiMJf2bU6V7xg_1763125677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D969318AB41F;
	Fri, 14 Nov 2025 13:07:56 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.185])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0F44180049F;
	Fri, 14 Nov 2025 13:07:55 +0000 (UTC)
Date: Fri, 14 Nov 2025 08:07:53 -0500
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Increase sched_tick_remote timeout
Message-ID: <20251114130753.GA21708@pauld.westford.csb>
References: <20250911161300.437944-1-pauld@redhat.com>
 <176312274606.498.4882667650358877046.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176312274606.498.4882667650358877046.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Nov 14, 2025 at 12:19:06PM -0000 tip-bot2 for Phil Auld wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     2616d12247639da40339757adc08c822147aa993
> Gitweb:        https://git.kernel.org/tip/2616d12247639da40339757adc08c822147aa993
> Author:        Phil Auld <pauld@redhat.com>
> AuthorDate:    Thu, 11 Sep 2025 12:13:00 -04:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 14 Nov 2025 13:03:06 +01:00
>

Thanks Peter!  


> sched: Increase sched_tick_remote timeout
> 
> Increase the sched_tick_remote WARN_ON timeout to remove false
> positives due to temporarily busy HK cpus. The suggestion
> was 30 seconds to catch really stuck remote tick processing
> but not trigger it too easily.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Link: https://patch.msgid.link/20250911161300.437944-1-pauld@redhat.com
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 68f19aa..699db3f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5619,7 +5619,7 @@ static void sched_tick_remote(struct work_struct *work)
>  				 * reasonable amount of time.
>  				 */
>  				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
> -				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> +				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
>  			}
>  			curr->sched_class->task_tick(rq, curr, 0);
>  
> 

-- 


