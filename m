Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE9FD977
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 10:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKOJkO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 04:40:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32912 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKOJkO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 04:40:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id w9so10240824wrr.0
        for <linux-tip-commits@vger.kernel.org>; Fri, 15 Nov 2019 01:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0h9Tq/Bjanc95O5ltpY0h0KaGHB8+stWBHgZ4wQ8Dbs=;
        b=korOTDg193HKr2LtuOLMizUAAw+vgterYe+195y4OfEfwZQ2tHd6vg3OGB0YAgtycv
         fFKxSY7jxIZgRbjF93tEJfUi381VPquoQhPEfSLXJ+xsG9fbReNbJr7DjsidhlyGm3e8
         k3gugSjP2P+GKYknQgiCxUC+kcIHdC44U9/qmFwTHVZ5F2c0zzUPTLGmbp36JVrWnnjP
         gtLn25jFUCgBnTZnMgDmVQzZ++DahqQardHs7J+plEZzHh5bphbsvUsNVSH8CHKItfyY
         L0faxdwEEwaw9pfWNQbxpfJFk7HSp5sG8S5tK3H5N4xH2J2+TIA5TUCBjTKk31sp/OeG
         WBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0h9Tq/Bjanc95O5ltpY0h0KaGHB8+stWBHgZ4wQ8Dbs=;
        b=ElDHsAbZz34hthUOWVmZBTdGfNbIpkVuPB2VBeyrDDE5sr0hWWZ5MAd6avLU41Mcea
         RBq0z0LdvTaDABo1BIsAUFaYzHI6nF047VJz01OFgtrJasGC7tz45fexCbagpAZ1tiv3
         /0iJSt5gbDQtA8DYRXYocwNkLGz32/XykxudEfJ9BPyRx0p1NV1VdObdCVa7U/sU9CKH
         F6jrCv2eU7vUNWUAv6cdkjwjqKxWdZ1bP9Rnk4wQkjcNHIQ45EjOgNje4FMH2RNlizIt
         /4cFdhMnF2706pkWbRWkx7YyhW697bGjNvQgL3xGepa/lZAXbODE5Frwn8UvjrHyUoW/
         KJaQ==
X-Gm-Message-State: APjAAAWtRWPMMa/XP5Sqkh6qwU92lHwMDrySsekmFTM+tPZPLepZ1ygo
        icNo1GuacsC5hp78Wcd/I58=
X-Google-Smtp-Source: APXvYqyHEHNXN85vmHqczYATCPD7EhVqSJmmkBj02Fw51WC7JuXBFIFvZfTClti/y7Jg8kSq1CNSkw==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr4501838wra.246.1573810812332;
        Fri, 15 Nov 2019 01:40:12 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c24sm13199422wrb.27.2019.11.15.01.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 01:40:11 -0800 (PST)
Date:   Fri, 15 Nov 2019 10:40:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
Message-ID: <20191115094009.GA25874@gmail.com>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115082604.GA18929@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Nov 15, 2019 at 07:28:55AM -0000, tip-bot2 for Cao jin wrote:
> > The following commit has been merged into the x86/cleanups branch of tip:
> > 
> > Commit-ID:     bff3dc88003badacb7ed685e301ab38dbdc36a8b
> > Gitweb:        https://git.kernel.org/tip/bff3dc88003badacb7ed685e301ab38dbdc36a8b
> > Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
> > AuthorDate:    Fri, 15 Nov 2019 13:08:28 +08:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 15 Nov 2019 08:26:07 +01:00
> > 
> > x86/numa: Fix typo
> > 
> > encomapssing -> encompassing.
> > 
> > Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> > Cc: <bp@alien8.de>
> > Cc: <dave.hansen@linux.intel.com>
> > Cc: <hpa@zytor.com>
> > Cc: <luto@kernel.org>
> > Cc: <peterz@infradead.org>
> > Cc: <tglx@linutronix.de>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Link: https://lkml.kernel.org/r/20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> This is all fine and good but this one and the other patch doesn't have
> the sender's SOB, i.e., that dude:
> 
> From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> 
> and I was about to point that out but you applied them already.
> 
> I'm guessing Shiyang is sending those because the author's mail has been
> bouncing recently. I guess he left or so...

Thanks, I missed that. I've removed these commits from x86/cleanups for 
the time being.

	Ingo
