Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21EE5FDC05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 12:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOLNE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 06:13:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1211 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbfKOLNE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 06:13:04 -0500
X-IronPort-AV: E=Sophos;i="5.68,308,1569254400"; 
   d="scan'208";a="78518422"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 19:13:01 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C926E4CE1BEC;
        Fri, 15 Nov 2019 19:04:46 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 19:13:06 +0800
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        <linux-tip-commits@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic> <20191115094009.GA25874@gmail.com>
 <9c43f148-479a-0aca-1577-30f686dcc90e@cn.fujitsu.com>
 <20191115104113.GJ18929@zn.tnic>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <756e5529-5550-f4d3-ba8b-8d247a479f31@cn.fujitsu.com>
Date:   Fri, 15 Nov 2019 19:13:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115104113.GJ18929@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: C926E4CE1BEC.ABB5F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 11/15/19 6:41 PM, Borislav Petkov wrote:
> On Fri, Nov 15, 2019 at 06:12:50PM +0800, Cao jin wrote:
>> Does them need to be resent with my college's SOB?
> 
> Please slow down and think before replying! I just pointed you to that
> document. I even wrote:
> 
> "If you do ask your colleague to send patches for you, he needs to
> add his SOB under yours because it shows this way that the patch went
> through him and it is important to know the path a patch took upstream."
> 
> Now if that is still unclear, ask and I'll try explaining again.
> 

I still need my colleague to send the patches for me for the time being,
since the patches are removed now, so I am actually asking: does these 2
patches need to be resent with my SOB & my college's SOB, or maintainer
can do that for us?

Not aware where I am wrong.

-- 
Sincerely,
Cao jin


