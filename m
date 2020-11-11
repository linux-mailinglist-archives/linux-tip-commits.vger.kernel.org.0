Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042682AF9DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 21:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgKKUic (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 15:38:32 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:41319 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgKKUic (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 15:38:32 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 15:38:31 EST
Received: from cust-43cce789 ([IPv6:fc0c:c1a4:736c:9c1a:15d2:fd0f:664c:4844])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id cwlOkE5k81R0xcwlekeNjH; Wed, 11 Nov 2020 21:31:15 +0100
Message-ID: <6356963f376a0798e8c939f813c2efe05d32c6d7.camel@tiscali.nl>
Subject: Re: [tip: sched/core] sched: Fix balance_callback()
From:   Paul Bolle <pebolle@tiscali.nl>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org
Date:   Wed, 11 Nov 2020 21:30:42 +0100
In-Reply-To: <160508300397.11244.13967684821070428528.tip-bot2@tip-bot2>
References: <20201023102346.203901269@infradead.org>
         <160508300397.11244.13967684821070428528.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfI5NAqjtXvsUEZoBrTlWkgokg/vtDBg3y1sqb0Im2Kh0B964hnZBPW0vF9IBSqnZ9f5wJK4WxvjjMi57LM+FA1gD9y88D3Qlxgw++mYsursjeCV2o+v+
 ldnGZHSYGyG/D3ey7SLHFYuqZDP7vUwXi58mbwGFUvj4Ph69GQQLwtcAux6LsBM/Cor/KechE2wrqYgxjh/Bn8QdUd/pOtPnBHeqLvTtq+50Tj9+ranpzJSq
 OweqVU/4mXvazjv4LHjXG1+TGmjI+epaVgxzlDgA9xsGuF5D6TKH7B7Rug/8ZVG28xMdnTx+S9xTXzfGH6oA1xR8UQyShmvU2ncBKhmCM8Iowz/4UVahSqkB
 eX6uhuUp6XKqvNTKFFzNRZCvbasI175EWI/amnaUET/UrC/OKoKXvFcdKfNkaLg8uJttOnyaC51NJi7TxfOdqVWHruSMRd5ZaqvJhOV57OMqiAVlg+Y=
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

tip-bot2 for Peter Zijlstra schreef op wo 11-11-2020 om 08:23 [+0000]:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> [...]
> +static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
> +{
> +	void (*func)(struct rq *rq);
> +	struct callback_head *next;
> +
> +	lockdep_assert_held(&rq->lock);
> +
> +	while (head) {
> +		func = (void (*)(struct rq *))head->func;
> +		next = head->next;
> +		head->next = NULL;
> +		head = next;

Naive question: is there some subtle C-issue that is evaded here by setting
head->next to NULL prior to copying over it?

(I know this piece of code only got copied around in this patch and this is
therefor not something that this patch actually introduced.)

> +
> +		func(rq);
> +	}
> +}

Thanks,


Paul Bolle

