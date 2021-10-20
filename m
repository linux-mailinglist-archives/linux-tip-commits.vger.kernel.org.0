Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4734354B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTUmi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 16:42:38 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:32225
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230020AbhJTUmh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 16:42:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlX1pgzBv40keFH1HKcgxGQfpXHEHvIrcq27jpLTw7H7uiVattab9eq91GWRhqPk0UU1ORke33/uh+7lDYMCLJxcDp0JJWcXd/cLAtuq7uulZ7w0zJow8KmKrMIIw6JJUvj4XZMu4Djj/KHSrCkUZT9Mc0+h9wTTa9wLMIWJIAk137wbaESi8Gf8OZxLnV4W0MnpY3JYMrSqVAWx8z3Um5NhhwkCP0Rs2UZMFTMj7pR1tss54tedbu1p0Lyh0VlwXGvpMxK/IVg6URUQUSvka7tMfLANcfTRdtU7Jn2JfbmQapYvOGyMS+zQj9jREKKpmXPNlG9EVq5Ncw0hZmm9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew0MS4MIk92WY8Qx6Kz6+h8MSVA/djxagTIdsmtALcg=;
 b=KSo8aFd/QWbCFRd6G/+fs9kAtne2hx9aWqf17e4A2mw0WPiyFzFdRkErk614SGf4AKdU9EPnduMLO2aouXD8szI6vplon7XzuPAJrxkpBHq6xYZs/doo+KFZFWXBkEwchgfs9WGZyKUK7BRXPJPueI6x/G0zKP0UfFpgvcB7vLFxi/uFQqDG4k0C8TqUNe81xm3oQTrifeair14o1XlBa5PjeA3zjr5H49Tji77Vw0o0RzNFnvK9dBcwf27oEp111MhjNiYT29L2tnVq5Yk40AfJ8GnwcXHBgwADJkKWzhlSUKVy4fSsdwD4mz9brDdXSS+n558XREVyJ/n9Y0ad2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew0MS4MIk92WY8Qx6Kz6+h8MSVA/djxagTIdsmtALcg=;
 b=deldnpdcJ2xWycUmi6hDR75djui1FeSRCOO0WfDSKCmoEqIzPu7uW8LCAXV34ZB9bmNjW21bUGq57bChFESudm3zrcTFMbPO4nTkEXcuuVi74y4u3+VynIHrU9bIhaZBiLc9ULSw9sqw+vrsRX7Mv0zX/4Bzzbos82wtpjdZ44s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 20:40:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 20:40:20 +0000
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
To:     Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
 <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f1641817-0f35-818c-7fa9-88ee5b405de5@amd.com>
Date:   Wed, 20 Oct 2021 15:40:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211020203619.GC174730@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by BL1PR13CA0337.namprd13.prod.outlook.com (2603:10b6:208:2c6::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Wed, 20 Oct 2021 20:40:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a410a28c-a1cf-4101-0b71-08d99409d554
X-MS-TrafficTypeDiagnostic: DM8PR12MB5463:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54634403B5D8B67CC4D12303ECBE9@DM8PR12MB5463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isPTVbznq4jwRalhH1yNrf5Sq/UmGt2cPFfgpZrbzT4eBrims3M9PFNK+ozc728+YNRnIjGxiA1Vfdo0HdDjo20k8G6x1D4d9ZVXzcLgHLoSE2It7dAqA+bLxJeyqZD7tre2pXjBIoNLvoDgfjhOPjg/nPFiQ5P5I7t9w144/Ys2HmSpluR3+PJzVyb1VOgOZWuItBNXsZwgmIV53NmA88/v7mTPHMtcBsJf7dbNm1MRAnDBEq1MLWkEwjwx+lX1uw5tqZIICjpibppQ6Yct/RN5i+muka9tWGI3p3LadHEymZPVcBnJCeIeFvfldns/+Nd3pE9zFeyY02BFsTuP1yUiOmAD0Yl8nyqH3TOJFmKB8eZKEm3sJf3x3nIM6UoRw71UU44QGy2PuUjAvNiGtdxtuyt3K7m/uJrcNa5fQxWBwFM7KZ6Rh28ZUgxlo8OSneVeLiTu5tuaZB41mxp6pOCUANy+rQoha997hnRhcfdiGaXAvzNRYjqb8Frpu3pKyqDL7cxXisxG3yPhzyYJpEzpgAJ5eCAQF0pRhJOcrZnPSakGWzNz0bWgPePwNNlZX+QONYbXsd0wkzseBThmgdBY2a0nuz2m6IKcQDHvnG/Y3f8y8xmVZYw/RiR3O0XZJPBJAdftHw0xa02PMif3NGUmK+D5PXc+i0GtWA2L9RTkqjcdLow+nkLtOdYIjNzQI2xoZ9q134iexLsUaNLv5XQKmsvclezUDSclsyB0J5kjl2//9bGRIxc3AfCUy0LF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(508600001)(8936002)(6486002)(2616005)(38100700002)(4326008)(66556008)(5660300002)(31686004)(316002)(26005)(6636002)(2906002)(956004)(110136005)(66476007)(53546011)(66946007)(54906003)(16576012)(186003)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhsazBsdDRySERLeDJQdk5yMDlTS25XeWJTU0orLzVjRzQ2Q3RKYVF5WHFE?=
 =?utf-8?B?MnpCTWh3dUhmUkJQRmNDblRTMThKeFRaTFM5UStXZHV4TmFNbGtWdngxSGxG?=
 =?utf-8?B?UURRVm00TjZiSkJRbllxZjRHeDduNThZWEErTkRISGhxaGsyMThXcWM4Y2Fv?=
 =?utf-8?B?OVd2ZVBES2VLWGNCSmFmSTA2L1FTSThXR0FKMDl4TVY0RGtoUlRFUlA2d2Ey?=
 =?utf-8?B?ZG8xK3R4VXVPOGNpMXVSR2RoclM1Ky9OL1ZGT2hKcVZxRGx6SjVmMHRUazgw?=
 =?utf-8?B?aTN3NzBodmlIZWYwalAyczAzQmhibVEwNFVZczZzVGN0ZG9iUmlwVEhqMkRy?=
 =?utf-8?B?bmQ3SllSem01VFJiWUROMG5DVXN3amZsZDVKK1dtSFdnalVHOVRSYnFxdkgx?=
 =?utf-8?B?WUo2Q2xqMjdBVkdTK21Pa3NCaTVVQ3I4L2pUVzNRRkltamxqQU9BS2FkZnlL?=
 =?utf-8?B?TjdOQ0IrdStUUnMzanQ1Ty9tRTR3MHdxdGdPK0g2ZElJb00yNjdUMkN5RG9r?=
 =?utf-8?B?TUFNcmFSYkxqUFI3ak5qeS9OUWVmMittTWdTSXhwVHVPOFd6RWFvQWVBaG90?=
 =?utf-8?B?akx0bjNLQ2xsWXYrODFQUkdRbEFyZ3k1WHkxWVl0eDZCREY0KzlwS014MGRE?=
 =?utf-8?B?NzdndElRT0NIakVCaE9LT0NCSnQ0NE1kc1pNTWRaUWhsOEYxTXBLNHhra09G?=
 =?utf-8?B?aHE1SGtKV2g0RU9mU25aSWpEUmY3QmpmQnBIazB2RnI3QzA5Z2RPYkNyMXJT?=
 =?utf-8?B?WTJOMWZHbjRQNmsrTnp4WFUzL2ZwNHM3VCtMMkdNVHR5THhONk1ubWl2dERk?=
 =?utf-8?B?RS9IbHB1cWdZZmZsVXovWDY2aGx6V2JzTTFvTmV6emhzREt0R25mQmZUa0VB?=
 =?utf-8?B?UDdWZVB3TkFvREZoTTB0UlVSMFVMeVMwOUUrRCsvRDlKN293RjBrSlVNeHFw?=
 =?utf-8?B?aDAxWWdiSUg2WGc2aWV6NkVPSUhxRS9RQVlvUUNVa3ZPQjVKMWtjNnJQRVM2?=
 =?utf-8?B?S3F5cjc0Q1ZQazQvRFRtQmUwMmFjYngvNGJzZ2hPVGhPUmtwR3ZaYVM0TkNB?=
 =?utf-8?B?V1QxQ2FLUXh0NDIyWEFmUjVWZWN5M0U4WExKanRlVE1tRG1hM21GL28xYTN5?=
 =?utf-8?B?WmtaanZHT0F5YUE3eG1uVGZndGprRWg5dk5JY25yQlNTcTkrYW5HeFQwVkpS?=
 =?utf-8?B?Vy9rMUU4OGxsYjFDSk9IUEY1UldVcm5CS01UZ2VKQit0dGZEMnNhNHV3T1dG?=
 =?utf-8?B?VEMvTEhIVXBLbWNLZTJVNVVKZlZpZitvdGhpVUEyd2FjdmdKQ0ZaZk9TSW82?=
 =?utf-8?B?RjQ0ZCs1YnB5UjA0Q3pDZk51TEo0bUtqeWxmelhZbGpBY0NaaWdGVnlzcTJ6?=
 =?utf-8?B?dGlROUNjMS9HUkJPRzJXZ0lwWDd3V3h4NWd2dGtUaEJuV3Q0NWVTRDlJVXJD?=
 =?utf-8?B?TFY2WmUrckIzS2xaUEF1MlluMmpLUU1BTDFWTnhCS0VneXovYWl2M3lpeVJE?=
 =?utf-8?B?cVFydmxjaWhzKzhqZmZDcnkzS1RudHlybjFOMUE3ZVFPV0dUUzZqcTVDUWlT?=
 =?utf-8?B?NTFmdXl1K2padjZQS3R1YlZXNTdRdVlXMy8rNkZSajhuOXFocGdodXBZa3Iy?=
 =?utf-8?B?VjBTdDl5T1R0dGhyUHByNGM2cmt2TmNwbjl3eGJpWWFvNTJRcUM1dGdLNjAy?=
 =?utf-8?B?a3VNQmc5YlBzMUprSHBGeGtQalVITHpjU0RFYlczS1Via1dRRmw4OG1tRFRv?=
 =?utf-8?B?dlBrRzl1L2lBTDF3OUlRUDlaVm9Cb2VOOE5BdTZoRGYzanBjYjVPaEdGK3pU?=
 =?utf-8?B?SlFIY0xSTWNLZForK0UzcFQ0aW1MUFVWU1lhdjZHT3pVUHNTekN4Ukg2c3B0?=
 =?utf-8?B?NTlIa1V6blp0eFlEcEN0dTBucmFRcEMxUkdwSGFETWI4ci83anFFSWVLc0Zp?=
 =?utf-8?Q?MUl7+mbXrgg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a410a28c-a1cf-4101-0b71-08d99409d554
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 20:40:20.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 10/20/21 3:36 PM, Peter Zijlstra wrote:
> On Wed, Oct 20, 2021 at 10:25:42PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 20, 2021 at 03:08:41PM -0500, Tom Lendacky wrote:
>>> On 10/20/21 2:51 PM, Peter Zijlstra wrote:
>>>> On Wed, Oct 20, 2021 at 08:12:51AM -0500, Tom Lendacky wrote:
>>>>> On 10/15/21 4:44 AM, tip-bot2 for Tim Chen wrote:
>>>>>> The following commit has been merged into the sched/core branch of tip:
>>>
>>>>
>>>> If it does boot, what does something like:
>>>>
>>>>     for i in /sys/devices/system/cpu/cpu*/topology/*{_id,_list}; do echo -n "${i}: " ; cat $i; done
>>>>
>>>> produce?
>>>
>>> The output is about 160K in size, I'll email it to you off-list.
>>
>> /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list: 0
>> /sys/devices/system/cpu/cpu0/topology/core_cpus_list: 0,128
>>
>> /sys/devices/system/cpu/cpu128/topology/cluster_cpus_list: 128
>> /sys/devices/system/cpu/cpu128/topology/core_cpus_list: 0,128
>>
>> So for some reason that thing thinks each SMT thread has it's own L2,
>> which seems rather unlikely. Or SMT has started to mean something
>> radically different than it used to be :-)
>>
>> Let me continue trying to make sense of cacheinfo.c
> 
> OK, I think I see what's happening.
> 
> AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
> means it's set to BAD_APICID.
> 
> This then results in match_l2c() to never match. And as a direct
> consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
> just the one CPU set.
> 
> And we have the above result and things come unstuck if we assume:
>    SMT <= L2 <= LLC
> 
> Now, the big question, how to fix this... Does AMD have means of
> actually setting l2c_id or should we fall back to using match_smt() for
> l2c_id == BAD_APICID ?

Let me include Suravee, who has more experience with our topology and 
cache information.

Thanks,
Tom

> 
