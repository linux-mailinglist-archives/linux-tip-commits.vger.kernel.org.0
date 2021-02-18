Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB031EE62
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Feb 2021 19:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhBRSdu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Feb 2021 13:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhBRRy4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Feb 2021 12:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613670800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VW1Q2+1iFqoUfBSiPmkrPPSwmqMxBigF4EWYAHJxNqQ=;
        b=YS35kkYs/EUSHvCjmHkH/QG4ZJD3xWMYVD0duEG1bDbzh01s0T/B6thvnjfHgpu4AlMsge
        OELsykKPSn62+BqVyDwWORWoOrKSijGEFix5Kqq5TwpMa1llLckLmnuxW7Ndsrjw0hlCTW
        6IhP2P+ln1KoqSMBwSv3omSlaALunZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-3DI1ck2FMbiiqnThmWtm7Q-1; Thu, 18 Feb 2021 12:53:18 -0500
X-MC-Unique: 3DI1ck2FMbiiqnThmWtm7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 665F96D4E6;
        Thu, 18 Feb 2021 17:53:17 +0000 (UTC)
Received: from treble (ovpn-117-118.rdu2.redhat.com [10.10.117.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B85F210023B8;
        Thu, 18 Feb 2021 17:53:16 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:53:14 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org
Subject: Re: [PATCH] objtool: Fix stack-swizzle for FRAME_POINTER=y
Message-ID: <20210218175314.sdrkb3272bzezw3b@treble>
References: <161298728344.23325.15458416903870844675.tip-bot2@tip-bot2>
 <YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Feb 18, 2021 at 05:21:31PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 10, 2021 at 08:01:23PM -0000, tip-bot2 for Peter Zijlstra wrote:
> > objtool: Support stack-swizzle
> 
> ---
> Subject: objtool: Fix stack-swizzle for FRAME_POINTER=y
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Feb 18 17:14:10 CET 2021
> 
> When objtool encounters the stack-swizzle:
> 
> 	mov %rsp, (%[tos])
> 	mov %[tos], %rsp
> 	...
> 	pop %rsp
> 
> Inside a FRAME_POINTER=y build, things go a little screwy because
> clearly we're not adjusting the cfa->base. This then results in the
> pop %rsp not being detected as a restore of cfa->base so it will turn
> into a regular POP and offset the stack, resulting in:
> 
>   kernel/softirq.o: warning: objtool: do_softirq()+0xdb: return with modified stack frame
> 
> Therefore, have "mov %[tos], %rsp" act like a PUSH (it sorta is
> anyway) to balance the things out. We're not too concerned with the
> actual stack_size for frame-pointer builds, since we don't generate
> ORC data for them anyway.
> 
> Fixes: aafeb14e9da2 ("objtool: Support stack-swizzle")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

