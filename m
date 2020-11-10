Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA89C2ADCED
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgKJR2v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 12:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJR2v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 12:28:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1509C0613CF;
        Tue, 10 Nov 2020 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HmUTZYGrR/d2vlH5DfUaqIdhg5JyXUfN+e9H+G1so7Y=; b=O87/okRKGoZqB8rEmfQg1N2Uvz
        I+k/a0S4IlQ43WJzql61DHZINpXV7IIlx9xTCeYi3oXgjo6zEIf06fAeNzq2xA3D9OfYiMP76jHEw
        GXCxHDzGv9/LvXcpjyW+BNmG0bVR5J2dPjOUI830ML9/jjYd1QInxu0hdfSxt1IxiXepEWF0ilb+4
        2UFdMrHOE5TUtzJXIEx42UDI0cButAh7BzuMs3/oMnrw9CTNxqdhr9PUGmSfweambA6tYKJP4EcFc
        3ffFoepILDPSRIVy2Lon0YFU9YAcpteJUERKnagI2eQ5gKkGE50uoZf71zvtMqnqUwL8+GqepMy4f
        0UCNw2xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcXRh-0004MV-T1; Tue, 10 Nov 2020 17:28:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6FCD307197;
        Tue, 10 Nov 2020 18:28:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C14142BDD3947; Tue, 10 Nov 2020 18:28:38 +0100 (CET)
Date:   Tue, 10 Nov 2020 18:28:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Qian Cai <cai@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: Avoid to modify chain keys in
 validate_chain()
Message-ID: <20201110172838.GP2594@hirez.programming.kicks-ass.net>
References: <20201030093806.GA2628@hirez.programming.kicks-ass.net>
 <20201102053743.450459-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102053743.450459-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Nov 02, 2020 at 01:37:41PM +0800, Boqun Feng wrote:
> Chris Wilson reported a problem spotted by check_chain_key(): a chain
> key got changed in validate_chain() because we modify the ->read in
> validate_chain() to skip checks for dependency adding, and ->read is
> taken into calculation for chain key since commit f611e8cf98ec
> ("lockdep: Take read/write status in consideration when generate
> chainkey").
> 
> Fix this by avoiding to modify ->read in validate_chain() based on two
> facts: a) since we now support recursive read lock detection, there is
> no need to skip checks for dependency adding for recursive readers, b)
> since we have a), there is only one case left (nest_lock) where we want
> to skip checks in validate_chain(), we simply remove the modification
> for ->read and rely on the return value of check_deadlock() to skip the
> dependency adding.
> 
> Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Thanks Boqun!
