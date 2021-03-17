Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AE33F1E0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 14:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhCQN43 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 09:56:29 -0400
Received: from casper.infradead.org ([90.155.50.34]:36766 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhCQNz4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 09:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oyq8/UTMFX2svFvS7h/tZWSi3AUrFmAIgDYpVCoWS2E=; b=N/IEnLA769w9TNWclakM6RqUMR
        HcAAdGZhNTFVNs7UzlrW9lJIHpnPXto612S7aK/m0d7rM81pZzw1SplZNyEgANmAkHsl/B8WRuDfS
        /cVa1bYt4Up0nWnHIo6y3VjSDDQRDeX93OZU7IY9O0Xp9hm9a8ik77QC+Poktwi6yo2ezQH6dVwdp
        SnNCZljBChz8XkUnfe0//1wGAOWdmd6rmwzGQVwNVhx62uTxPVnzEClkXfoDL2hwkHLPN1j+uJhUk
        tJXvcz+7I1Gq4hwReFP7I1h+FQ1+tzIpEMp2NVLAOsFAd1fPUkn6T6/MA792tfpo9OlizqgDytFls
        WWs/doJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMWe8-001X8Q-Ob; Wed, 17 Mar 2021 13:55:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60596300130;
        Wed, 17 Mar 2021 14:55:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 565C620781083; Wed, 17 Mar 2021 14:55:36 +0100 (CET)
Date:   Wed, 17 Mar 2021 14:55:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Simplify use_ww_ctx &
 ww_ctx handling
Message-ID: <YFIKWCUAZabBsji0@hirez.programming.kicks-ass.net>
References: <20210316153119.13802-2-longman@redhat.com>
 <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
 <YFH9Pw3kwCZC1UTB@hirez.programming.kicks-ass.net>
 <85fbce04-c544-6041-6e7d-76f47b90e263@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85fbce04-c544-6041-6e7d-76f47b90e263@redhat.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 09:43:20AM -0400, Waiman Long wrote:

> Using gcc 8.4.1, the generated __mutex_lock function has the same size (with
> last instruction at offset +5179) with or without this patch. Well, you can
> say that this patch is an no-op wrt generated code.

OK, then GCC has gotten better. Because back then I tried really hard
but it wouldn't remove the if (ww_ctx) branches unless I had that extra
const bool argument.
