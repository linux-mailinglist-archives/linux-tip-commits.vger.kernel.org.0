Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DB2FD80C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 09:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfKOIkQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 03:40:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36719 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726930AbfKOIkQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 03:40:16 -0500
X-IronPort-AV: E=Sophos;i="5.68,307,1569254400"; 
   d="scan'208";a="78499261"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 16:40:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id EA0754B6EC71;
        Fri, 15 Nov 2019 16:32:00 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 16:40:21 +0800
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
CC:     <linux-tip-commits@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <73ffdd4c-d74d-e3c0-7cd5-f97e7061caeb@cn.fujitsu.com>
Date:   Fri, 15 Nov 2019 16:41:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115082604.GA18929@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: EA0754B6EC71.A8C16
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 11/15/19 4:26 PM, Borislav Petkov wrote:
> On Fri, Nov 15, 2019 at 07:28:55AM -0000, tip-bot2 for Cao jin wrote:
>> The following commit has been merged into the x86/cleanups branch of tip:
>>
>> Commit-ID:     bff3dc88003badacb7ed685e301ab38dbdc36a8b
>> Gitweb:        https://git.kernel.org/tip/bff3dc88003badacb7ed685e301ab38dbdc36a8b
>> Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
>> AuthorDate:    Fri, 15 Nov 2019 13:08:28 +08:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Fri, 15 Nov 2019 08:26:07 +01:00
>>
>> x86/numa: Fix typo
>>
>> encomapssing -> encompassing.
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> Cc: <bp@alien8.de>
>> Cc: <dave.hansen@linux.intel.com>
>> Cc: <hpa@zytor.com>
>> Cc: <luto@kernel.org>
>> Cc: <peterz@infradead.org>
>> Cc: <tglx@linutronix.de>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lkml.kernel.org/r/20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
> 

Sorry for the confusion. I asked my college to send the patch for me
because my git send-email has been down for a while, I guess it is
because our mail server is upgrading. But my thunderbird works fine, no
clue.
-- 
Sincerely,
Cao jin


