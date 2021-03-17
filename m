Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED53933F24F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 15:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhCQOKY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 10:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230051AbhCQOKV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 10:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615990220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65P6PL5OL/2717NBzXNqPQ+q5PP+bR0voBu5yKlNlo8=;
        b=K1qmvEhBz7rIT+4lQYGPYQxAzPDu8T1vBEYhZ6CG6k9/MxajeuH6upiBOBPTBcPpLehCII
        GrWJkk9r43QVQab7fR1KkEISGQlrVihyDxRJyfMBXSQUKGgeCLUmE6h/9G7/1Btb+0y6yx
        VQOhUoU/y87N6sGb+8WhqjMBeFyzcuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-BWa9y-b_NPC7rsWPf4OW1Q-1; Wed, 17 Mar 2021 10:10:18 -0400
X-MC-Unique: BWa9y-b_NPC7rsWPf4OW1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9016AEC1A1;
        Wed, 17 Mar 2021 14:10:17 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5DE650DDB;
        Wed, 17 Mar 2021 14:10:16 +0000 (UTC)
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Simplify use_ww_ctx &
 ww_ctx handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org
References: <20210316153119.13802-2-longman@redhat.com>
 <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
 <YFH9Pw3kwCZC1UTB@hirez.programming.kicks-ass.net>
 <85fbce04-c544-6041-6e7d-76f47b90e263@redhat.com>
 <YFIKWCUAZabBsji0@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bbfca577-b680-4c73-3f35-22179bd1a498@redhat.com>
Date:   Wed, 17 Mar 2021 10:10:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFIKWCUAZabBsji0@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 3/17/21 9:55 AM, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 09:43:20AM -0400, Waiman Long wrote:
>
>> Using gcc 8.4.1, the generated __mutex_lock function has the same size (with
>> last instruction at offset +5179) with or without this patch. Well, you can
>> say that this patch is an no-op wrt generated code.
> OK, then GCC has gotten better. Because back then I tried really hard
> but it wouldn't remove the if (ww_ctx) branches unless I had that extra
> const bool argument.
>
I think ww_mutex was merged in 2013. That is almost 8 years ago. It 
could still be the case that older gcc compilers may not generate the 
right code. I will try the RHEL7 gcc compiler (4.8.5) to see how it fares.

Cheers,
Longman

