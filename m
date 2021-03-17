Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CEA33F2B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 15:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCQOdn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 10:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231858AbhCQOdT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 10:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615991599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=usqdCKtdXoW4nYQBrZ9v4lz6SSdt8idRgvW77OKUkAc=;
        b=gH+NQKQ/ZwAq2OGR2hg+b8aWH2GNN1TEcsOHU6aXGvTXk9vEfGfXIFXRlXLLkWHramOeGz
        S+IlBYQ/ux9/MKb38+faP0rfvGKXtr6R5F00jeWb24tN3QPv4LeRfTvs+lTnAhyiEILBJ0
        23vHZlHXAlu01UutcBsKgtLGPkagOkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-64uKjlpHPgir_JH28Zo4Ng-1; Wed, 17 Mar 2021 10:33:15 -0400
X-MC-Unique: 64uKjlpHPgir_JH28Zo4Ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8EA08189CB;
        Wed, 17 Mar 2021 14:33:13 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 164345C1CF;
        Wed, 17 Mar 2021 14:33:12 +0000 (UTC)
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Simplify use_ww_ctx &
 ww_ctx handling
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org
References: <20210316153119.13802-2-longman@redhat.com>
 <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
 <YFH9Pw3kwCZC1UTB@hirez.programming.kicks-ass.net>
 <85fbce04-c544-6041-6e7d-76f47b90e263@redhat.com>
 <YFIKWCUAZabBsji0@hirez.programming.kicks-ass.net>
 <bbfca577-b680-4c73-3f35-22179bd1a498@redhat.com>
Organization: Red Hat
Message-ID: <4a40bcd9-f0ff-4fd5-19dc-e71961c3c4c6@redhat.com>
Date:   Wed, 17 Mar 2021 10:33:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <bbfca577-b680-4c73-3f35-22179bd1a498@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 3/17/21 10:10 AM, Waiman Long wrote:
> On 3/17/21 9:55 AM, Peter Zijlstra wrote:
>> On Wed, Mar 17, 2021 at 09:43:20AM -0400, Waiman Long wrote:
>>
>>> Using gcc 8.4.1, the generated __mutex_lock function has the same 
>>> size (with
>>> last instruction at offset +5179) with or without this patch. Well, 
>>> you can
>>> say that this patch is an no-op wrt generated code.
>> OK, then GCC has gotten better. Because back then I tried really hard
>> but it wouldn't remove the if (ww_ctx) branches unless I had that extra
>> const bool argument.
>>
> I think ww_mutex was merged in 2013. That is almost 8 years ago. It 
> could still be the case that older gcc compilers may not generate the 
> right code. I will try the RHEL7 gcc compiler (4.8.5) to see how it 
> fares. 

I got the same result with the 4.8.5 compiler. The __mutex_lock() 
function has the same size with or without the patch. Note that I used 
the debug config during my RHEL8 compiler test, so the generated code 
size is much larger. With the non-debug config that I used for the 4.8.5 
compiler test, the code is only about 1236 bytes.

Since the current Linux kernel requires gcc 4.9 or above (I downgraded 
the kernel to v5.4 for my 4.8.5 compiler test), the fear of generating 
inferior code due to this patch should be a moot point.

Cheers,
Longman

