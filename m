Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8591F53AC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jun 2020 13:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgFJLm4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Jun 2020 07:42:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgFJLm4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Jun 2020 07:42:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 369C2B001;
        Wed, 10 Jun 2020 11:42:56 +0000 (UTC)
Subject: Re: [tip: x86/entry] x86/entry/32: Use IA32-specific wrappers for
 syscalls taking 64-bit arguments
From:   Jiri Slaby <jslaby@suse.cz>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        x86 <x86@kernel.org>
References: <20200313195144.164260-16-brgerst@gmail.com>
 <158480463257.28353.7220752053626182323.tip-bot2@tip-bot2>
 <07d39c26-ff51-1d34-616d-e1d525bda04f@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a5b51084-f289-3363-a77b-ca3bf55d78b6@suse.cz>
Date:   Wed, 10 Jun 2020 13:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <07d39c26-ff51-1d34-616d-e1d525bda04f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 10. 06. 20, 13:29, Jiri Slaby wrote:
> On 21. 03. 20, 16:30, tip-bot2 for Brian Gerst wrote:
>> The following commit has been merged into the x86/entry branch of tip:
>>
>> Commit-ID:     121b32a58a3af89a780cf194ce3769fc4120e574
>> Gitweb:        https://git.kernel.org/tip/121b32a58a3af89a780cf194ce3769fc4120e574
>> Author:        Brian Gerst <brgerst@gmail.com>
>> AuthorDate:    Fri, 13 Mar 2020 15:51:41 -04:00
>> Committer:     Thomas Gleixner <tglx@linutronix.de>
>> CommitterDate: Sat, 21 Mar 2020 16:03:24 +01:00
>>
>> x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments
>>
> 
> Hi,
> 
> this breaks creation of sparse files (e.g. by tar) on i586 (in 5.7).
> 
> tar does this:
>> openat(4, "sparsefile", O_WRONLY|O_CREAT|O_EXCL|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_CLOEXEC, 0600) = 5
>> _llseek(5, 0, [0], SEEK_SET)      = 0
>> _llseek(5, 8589934592, [8589934592], SEEK_SET) = 0
>> write(5, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 512) = 512
>> _llseek(5, 8589935104, [8589935104], SEEK_SET) = 0
>> _llseek(5, 0, [8589935104], SEEK_CUR) = 0
>> ftruncate64(5, 8589935104)        = 0
>> utimensat_time64(5, NULL, [UTIME_OMIT, {tv_sec=1591782127, tv_nsec=400000000} /* 2020-06-10T11:42:07.400000000+0200 */], 0) = 0
>> fchown32(5, 0, 0)                 = 0
>> fchmod(5, 0644)                   = 0
>> close(5)                          = 0
> 
> It should result in a sparsefile of size 8589935104, but after this
> commit, it's only 512 bytes.
> 
> The archive is this:
> XQAAgAD//////////wAXC8aHklo7p4/HJQ64D7SVnhAZOByg5PlRjaTJjmKhpQbF1loXWBYREoWY
> DagQFjCR/jUwLV7mWbgHwcINuoi1bu/eDQHOp5mXL9bq/twuolv5Y2krdqZEztWCBydhsNFwBxHi
> U47whwTByiH4Ot16JcEkr4BFWXHXMTRs1lfVmIOE13bldiM6MzQUC7212b81Rn13fw06uk+aoP74
> OvatxDoW95Y7/xeMyDQ7uk8L1OfFGVRfU+PFycrb1gDZc6hLY2kDY15PGxCMSzHHGDE3nTr9Imdw
> UoUYqYNhi3tztLuue2rvzngAsMvHIEJaE6i2E5+X7lwlHZhg9Wp2T9ow9DyaJYLr/N+Jln7P1C97
> 2hT9YzrPNupujamDoBv0kIA3zgAw/xHvZX/I3tfa5Z8+TjrhfgJ8poGKK1S1e8LR+657FbBH3B46
> HZFclvO0bUvL1xyRx0OPM1Dzzd+lH8VgF6RYHj1vDJCcR8nbtEfgN5W+cN44xdPO1VN/6Ffnj5Af
> 84sDSaBSn7HTnaaJRX0KPa3zfdUzTv/ykgihysjhxAV9CW02ZiVffVgrK5UHVuoWzqQ76+83fYsM
> rSWRtoL0a3eo/hbqPvHg1Q8dRvbjwLs610lu3QIkvQ0DOK7zUHx44ODHfLBS2LJcw5TCiU25xGCm
> NXS1oRaVdqnCV6Rl5KZHPiHF7ZRxQFQxLgreu8z0INZ41T74pGbfGvNRqyLy9wxiO4/uCICO0om/
> oHlgowb9RWX9/0Z2
> 
> Feed it through (on i586):
> mkdir directory; base64 -d | tar JxvC directory/
> 
> and check the size of directory/sparsefile.
> 
> Reverting the commit on the top of 5.7 doesn't help. I suppose it
> doesn't take the original path in the code there...
> 
> Any ideas?

Got it:
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1358,7 +1358,7 @@ static inline long ksys_lchown(const char __user
*filename, uid_t user,

 extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);

-static inline long ksys_ftruncate(unsigned int fd, unsigned long length)
+static inline long ksys_ftruncate(unsigned int fd, loff_t length)
 {
        return do_sys_ftruncate(fd, length, 1);
 }

Will send a patch in few minutes.

thanks,
-- 
js
suse labs
